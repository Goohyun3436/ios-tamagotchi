//
//  SettingViewModel.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: BaseViewModel {
    
    //MARK: - Input
    struct Input {
        let menuTap: ControlEvent<SettingMenu>
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: Observable<String>
        let menus: BehaviorRelay<[SettingMenu]>
        let resignAlert: PublishRelay<AlertInfo>
        let pushVC: PublishRelay<BaseViewController>
        let rootVC: PublishRelay<BaseViewController>
    }
    
    //MARK: - Private
    private struct Private {
        let navigationTitle = "설정"
        var user = BehaviorRelay(value: UserStaticStorage.info)
        var menus: [SettingMenu]
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private var priv: Private
    
    init() {
        self.priv = Private(
            menus: SettingMenuType.allCases.map {
                SettingMenu(
                    type: $0,
                    icon: $0.icon,
                    title: $0.title,
                    detailText: $0 == .userNickname ? UserStaticStorage.info.nickname : "",
                    accessoryImage: $0.accessoryImage
                )
            }
        )
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just(priv.navigationTitle)
        let menus = BehaviorRelay(value: priv.menus)
        let resignAlert = PublishRelay<AlertInfo>()
        let pushVC = PublishRelay<BaseViewController>()
        let rootVC = PublishRelay<BaseViewController>()
        
        priv.user
            .bind(with: self) { owner, user in
                owner.priv.menus[0].detailText = user.nickname
                menus.accept(owner.priv.menus)
            }
            .disposed(by: priv.disposeBag)
        
        input.menuTap
            .bind(with: self) { owner, menu in
                switch menu.type {
                case .userNickname:
                    pushVC.accept(
                        SettingNicknameViewController(
                            viewModel: SettingNicknameViewModel(
                                passNickname: { nickname in owner.updateNickname(nickname)}
                            )
                        )
                    )
                case .tgPicker:
                    pushVC.accept(TGPickerViewController(
                        viewModel: TGPickerViewModel(isOnboarding: false))
                    )
                case .resign:
                    resignAlert.accept(AlertInfo(
                        title: "데이터 초기화",
                        message: "정말 다시 처음부터 시작하실 건가용?",
                        submitHandler: {
                            UserStorage.shared.info = User()
                            TGStorage.shared.info = Tamagotchi()
                            rootVC.accept(TGPickerViewController(
                                viewModel: TGPickerViewModel(isOnboarding: true)
                            ))
                        }
                    ))
                }
            }
            .disposed(by: priv.disposeBag)
        
        
        return Output(
            navigationTitle: navigationTitle,
            menus: menus,
            resignAlert: resignAlert,
            pushVC: pushVC,
            rootVC: rootVC
        )
    }
    
    private func updateNickname(_ nickname: String) {
        var user = self.priv.user.value
        user.nickname = nickname
        self.priv.user.accept(user)
    }
    
}

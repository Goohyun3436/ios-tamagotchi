//
//  SettingNicknameViewModel.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

final class SettingNicknameViewModel: BaseViewModel {
    
    //MARK: - Input
    struct Input {
        let viewDidAppear: ControlEvent<Bool>
        let mainViewTap: ControlEvent<RxGestureRecognizer>
        let nickname: ControlProperty<String?>
        let editingDidEndOnExit: ControlEvent<()>
        let saveButtonTap: ControlEvent<()>?
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: Observable<String>
        let rightBarButtonTitle: Observable<String>
        let textFieldPlaceholder: Observable<String>
        let nickname: Observable<String>
        let showsKeyboard: PublishRelay<Bool>
        let alert: PublishRelay<AlertInfo>
        let popVC: PublishRelay<Void>
    }
    
    //MARK: - Private
    private struct Private {
        let navigationTitle = "대장님 이름 정하기"
        let rightBarButtonTitle = "저장"
        let textFieldPlaceholder = "대장님 이름을 알려주세요!"
        let user = UserStaticStorage.info
        let error = PublishRelay<NicknameValidationError>()
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private var priv = Private()
    private let passNickname: (String) -> Void
    
    //MARK: - Initializer Method
    init(passNickname: @escaping (String) -> Void) {
        self.passNickname = passNickname
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just(priv.navigationTitle)
        let rightBarButtonTitle = Observable.just(priv.rightBarButtonTitle)
        let textFieldPlaceholder = Observable.just(priv.textFieldPlaceholder)
        let nickname = Observable.just(priv.user.nickname)
        let showsKeyboard = PublishRelay<Bool>()
        let alert = PublishRelay<AlertInfo>()
        let popVC = PublishRelay<Void>()
        
        priv.error
            .map { AlertInfo(title: $0.title, message: $0.message) }
            .bind(to: alert)
            .disposed(by: priv.disposeBag)
        
        input.viewDidAppear
            .map { _ in true }
            .bind(to: showsKeyboard)
            .disposed(by: priv.disposeBag)
        
        input.mainViewTap
            .when(.recognized)
            .map { _ in false }
            .bind(to: showsKeyboard)
            .disposed(by: priv.disposeBag)
        
        input.editingDidEndOnExit
            .map { false }
            .bind(to: showsKeyboard)
            .disposed(by: priv.disposeBag)
        
        
        input.saveButtonTap?
            .withLatestFrom(input.nickname.orEmpty)
            .bind(with: self) { owner, text in
                do {
                    let nickname = try User.nicknameValidation(text)
                    UserStorage.shared.info.nickname = nickname
                    owner.passNickname(nickname)
                    popVC.accept(())
                } catch {
                    owner.priv.error.accept(error as! NicknameValidationError)
                }
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            navigationTitle: navigationTitle,
            rightBarButtonTitle: rightBarButtonTitle,
            textFieldPlaceholder: textFieldPlaceholder,
            nickname: nickname,
            showsKeyboard: showsKeyboard,
            alert: alert,
            popVC: popVC
        )
    }
}

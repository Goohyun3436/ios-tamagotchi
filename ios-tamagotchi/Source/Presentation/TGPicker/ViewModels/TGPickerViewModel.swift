//
//  TGPickerViewModel.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TGPickerViewModel: BaseViewModel {
    
    //MARK: - Input
    struct Input {
        let tamagotchiTap: ControlEvent<TamagotchiThumbnail>
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: Observable<String>
        let tamagotchis: BehaviorRelay<[TamagotchiThumbnail]>
        let presentVC: PublishRelay<BaseViewController>
        let popVC: PublishRelay<Void>
    }
    
    //MARK: - Private
    private struct Private {
        var isOnboarding: Bool
        let navigationTitle: String
        var tamagotchis: [TamagotchiThumbnail]
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private let priv: Private
    
    //MARK: - Initializer Method
    init(isOnboarding: Bool) {
        self.priv = Private(
            isOnboarding: isOnboarding,
            navigationTitle: "다마고치 \(isOnboarding ? "선택" : "변경")하기",
            tamagotchis: {
                var tamagotchiTypes = TamagotchiType.activeCases
                let empties = Array(repeating: TamagotchiType.empty, count: 18)
                tamagotchiTypes.append(contentsOf: empties)
                
                let userTGId = TGStaticStorage.info.id
                
                let tamagotchis = tamagotchiTypes.map {
                    let id = $0.index
                    
                    return TamagotchiThumbnail(
                        id: id,
                        image: $0.thumbnail,
                        name: "  \($0.name)  ",
                        intro: $0.intro,
                        isEnabled: id != userTGId && $0 != .empty,
                        opacity: id != userTGId ? 1 : 0.5
                    )
                }
                
                return tamagotchis
            }()
        )
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just(priv.navigationTitle)
        let tamagotchis = BehaviorRelay(value: priv.tamagotchis)
        let presentVC = PublishRelay<BaseViewController>()
        let popVC = PublishRelay<Void>()
        
        input.tamagotchiTap
            .bind(with: self) { owner, tamagotchi in
                let vc = TGPickerModalViewController(
                    viewModel: TGPickerModalViewModel(
                        isOnboarding: owner.priv.isOnboarding,
                        tamagotchi: tamagotchi
                    )
                )
                vc.modalPresentationStyle = .overCurrentContext
                presentVC.accept(vc)
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            navigationTitle: navigationTitle,
            tamagotchis: tamagotchis,
            presentVC: presentVC,
            popVC: popVC
        )
    }
    
}

//
//  TGPickerModalViewModel.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class TGPickerModalViewModel: BaseViewModel {
    
    //MARK: - Input
    struct Input {
        let cancelButtonTap: ControlEvent<Void>
        let submitButtonTap: ControlEvent<Void>
    }
    
    //MARK: - Output
    struct Output {
        let image: Observable<String>
        let name: Observable<String>
        let intro: Observable<String>
        let cancelButtonTitle: Observable<String>
        let submitButtonTitle: Observable<String>
        let dismissVC: PublishRelay<Void>
        let rootVC: PublishRelay<BaseViewController>
    }
    
    //MARK: - Private
    private struct Private {
        let isOnboarding: Bool
        let tamagotchi: TamagotchiThumbnail
        let cancelButtonTitle = "취소"
        let submitButtonTitle: String
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private let priv: Private
    
    //MARK: - Initializer Method
    init(isOnboarding: Bool, tamagotchi: TamagotchiThumbnail) {
        self.priv = Private(
            isOnboarding: isOnboarding,
            tamagotchi: tamagotchi,
            submitButtonTitle: isOnboarding ? "시작" : "변경" + "하기"
        )
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let image = Observable.just(priv.tamagotchi.image)
        let name = Observable.just(priv.tamagotchi.name)
        let intro = Observable.just(priv.tamagotchi.intro)
        let cancelButtonTitle = Observable.just(priv.cancelButtonTitle)
        let submitButtonTitle = Observable.just(priv.submitButtonTitle)
        let dismissVC = PublishRelay<Void>()
        let rootVC = PublishRelay<BaseViewController>()
        
        input.cancelButtonTap
            .bind(to: dismissVC)
            .disposed(by: priv.disposeBag)
        
        input.submitButtonTap
            .bind(with: self) { owner, _ in
                owner.save()
                rootVC.accept(MainViewController())
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            image: image,
            name: name,
            intro: intro,
            cancelButtonTitle: cancelButtonTitle,
            submitButtonTitle: submitButtonTitle,
            dismissVC: dismissVC,
            rootVC: rootVC
        )
    }
    
    private func save() {
        let tamagotchi = self.priv.tamagotchi
        var data: Tamagotchi
        
        switch self.priv.isOnboarding {
        case true:
            data = Tamagotchi(
                id: tamagotchi.id,
                image: TamagotchiType.image(id: tamagotchi.id, level: 1),
                name: tamagotchi.name,
                level: 1
            )
        case false:
            data = TGStaticStorage.info
            data.id = tamagotchi.id
            data.image = TamagotchiType.image(id: tamagotchi.id, level: data.level)
            data.name = tamagotchi.name
        }
        
        TGStorage.shared.info = data
    }
    
}

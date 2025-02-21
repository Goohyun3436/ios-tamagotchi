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
        let tamagotchi: TamagotchiThumbnail
        let cancelButtonTap: ControlEvent<Void>
        let startButtonTap: ControlEvent<Void>
    }
    
    //MARK: - Output
    struct Output {
        let image: Observable<String>
        let name: Observable<String>
        let intro: Observable<String>
        let cancelButtonTitle: Observable<String>
        let startButtonTitle: Observable<String>
        let dismissVC: PublishRelay<Void>
        let pushVC: PublishRelay<Void>
    }
    
    //MARK: - Private
    private struct Private {
        let cancelButtonTitle = "취소"
        let startButtonTitle = "시작하기"
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private let priv = Private()
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let image = Observable.just(input.tamagotchi.image)
        let name = Observable.just(input.tamagotchi.name)
        let intro = Observable.just(input.tamagotchi.intro)
        let cancelButtonTitle = Observable.just(priv.cancelButtonTitle)
        let startButtonTitle = Observable.just(priv.startButtonTitle)
        let dismissVC = PublishRelay<Void>()
        let pushVC = PublishRelay<Void>()
        
        input.cancelButtonTap
            .bind(to: dismissVC)
            .disposed(by: priv.disposeBag)
        
        input.startButtonTap
            .bind(with: self) { owner, _ in
                owner.save(input.tamagotchi)
                pushVC.accept(())
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            image: image,
            name: name,
            intro: intro,
            cancelButtonTitle: cancelButtonTitle,
            startButtonTitle: startButtonTitle,
            dismissVC: dismissVC,
            pushVC: pushVC
        )
    }
    
    private func save(_ tamagotchi: TamagotchiThumbnail) {
        let data = Tamagotchi(id: tamagotchi.id)
        TGStorage.shared.info = data
    }
}

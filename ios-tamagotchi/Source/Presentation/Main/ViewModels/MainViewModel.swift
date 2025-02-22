//
//  MainViewModel.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: BaseViewModel {
    
    //MARK: - Input
    struct Input {
        let viewWillAppear: ControlEvent<Bool>
        let rightBarButtonTap: ControlEvent<()>?
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: BehaviorRelay<String>
        let rightBarButtonImage: Observable<String>
        let bubbleText: PublishRelay<String>
        let pushVC: PublishRelay<Void>
    }
    
    //MARK: - Private
    private struct Private {
        var navigationTitle = ""
        let rightBarButtonImage = "person.circle"
        var user = User()
        var tamagotchi = Tamagotchi()
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    //MARK: - Initializer Method
    init() {
        priv.user = getUser()
        priv.tamagotchi = getTamagotchi()
        priv.navigationTitle = "\(priv.user.nickname)님의 다마고치"
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: priv.navigationTitle)
        let rightBarButtonImage = Observable.just(priv.rightBarButtonImage)
        let bubbleText = PublishRelay<String>()
        let pushVC = PublishRelay<Void>()
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                let text = owner.updateBubble(for: .enterView)
                bubbleText.accept(text)
            }
            .disposed(by: priv.disposeBag)
        
        input.rightBarButtonTap?
            .bind(with: self) { owner, _ in
                pushVC.accept(())
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            navigationTitle: navigationTitle,
            rightBarButtonImage: rightBarButtonImage,
            bubbleText: bubbleText,
            pushVC: pushVC
        )
    }
    
    private func getUser() -> User {
        return UserStaticStorage.info
    }
    
    private func getTamagotchi() -> Tamagotchi {
        return TGStaticStorage.info
    }
    
    private func updateBubble(for bubbleUpdate: BubbleUpdate) -> String {
        return bubbleUpdate.message(nickname: priv.user.nickname)
    }
    
}

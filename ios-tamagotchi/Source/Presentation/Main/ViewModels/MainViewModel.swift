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
        let riceButtonTap: ControlEvent<Void>
        let waterButtonTap: ControlEvent<Void>
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: BehaviorRelay<String>
        let rightBarButtonImage: Observable<String>
        let bubbleText: PublishRelay<String>
        let tgImage: BehaviorRelay<String>
        let tgName: BehaviorRelay<String>
        let tgInfo: BehaviorRelay<String>
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
        setUser()
        setTamagotchi()
        priv.navigationTitle = "\(priv.user.nickname)님의 다마고치"
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: priv.navigationTitle)
        let rightBarButtonImage = Observable.just(priv.rightBarButtonImage)
        let bubbleText = PublishRelay<String>()
        let tgImage = BehaviorRelay(value: priv.tamagotchi.image)
        let tgName = BehaviorRelay(value: priv.tamagotchi.name)
        let tgInfo = BehaviorRelay(value: priv.tamagotchi.info)
        let pushVC = PublishRelay<Void>()
        
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                let text = owner.updateBubble(for: .enterView)
                bubbleText.accept(text)
            }
            .disposed(by: priv.disposeBag)
        
        input.rightBarButtonTap?
            .bind(to: pushVC)
            .disposed(by: priv.disposeBag)
        
        input.riceButtonTap
            .bind(with: self) { owner, _ in
                TGStorage.shared.info.rice += 1
                
                //refactor point: priv.tamagotchi를 Observable로 관리
                owner.setTamagotchi()
                tgInfo.accept(owner.priv.tamagotchi.info)
                
                let text = owner.updateBubble(for: .rice)
                bubbleText.accept(text)
            }
            .disposed(by: priv.disposeBag)
        
        input.waterButtonTap
            .bind(with: self) { owner, _ in
                TGStorage.shared.info.water += 1
                owner.setTamagotchi()
                //refactor point: priv.tamagotchi를 Observable로 관리
                tgInfo.accept(owner.priv.tamagotchi.info)
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            navigationTitle: navigationTitle,
            rightBarButtonImage: rightBarButtonImage,
            bubbleText: bubbleText,
            tgImage: tgImage,
            tgName: tgName,
            tgInfo: tgInfo,
            pushVC: pushVC
        )
    }
    
    private func setUser() {
        priv.user = UserStaticStorage.info
    }
    
    private func setTamagotchi() {
        priv.tamagotchi = TGStaticStorage.info
    }
    
    private func updateBubble(for bubbleUpdate: BubbleUpdate) -> String {
        return bubbleUpdate.message(nickname: priv.user.nickname)
    }
    
}

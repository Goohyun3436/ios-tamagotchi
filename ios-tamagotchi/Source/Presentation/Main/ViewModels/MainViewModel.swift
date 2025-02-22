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
        let viewDidLoad: ControlEvent<Void>
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
        let tgImage: PublishRelay<String>
        let tgName: PublishRelay<String>
        let tgInfo: PublishRelay<String>
        let pushVC: PublishRelay<Void>
    }
    
    //MARK: - Private
    private struct Private {
        var navigationTitle = ""
        let rightBarButtonImage = "person.circle"
        var user = User()
        let bubbleText = PublishRelay<String>()
        let tamagotchi = PublishRelay<Tamagotchi>()
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    //MARK: - Initializer Method
    init() {
        setUser()
        priv.navigationTitle = "\(priv.user.nickname)님의 다마고치"
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: priv.navigationTitle)
        let rightBarButtonImage = Observable.just(priv.rightBarButtonImage)
        let bubbleText = PublishRelay<String>()
        let tgImage = PublishRelay<String>()
        let tgName = PublishRelay<String>()
        let tgInfo = PublishRelay<String>()
        let pushVC = PublishRelay<Void>()
        
        priv.bubbleText
            .bind(to: bubbleText)
            .disposed(by: priv.disposeBag)
        
        priv.tamagotchi
            .bind(with: self) { owner, tamagotchi in
                tgImage.accept(tamagotchi.image)
                tgName.accept(tamagotchi.name)
                tgInfo.accept(tamagotchi.info)
            }
            .disposed(by: priv.disposeBag)
        
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                owner.setTamagotchi()
            }
            .disposed(by: priv.disposeBag)
        
        input.viewWillAppear
            .withUnretained(self)
            .map { $0.0.updateBubble(for: .enterView) }
            .bind(to: priv.bubbleText)
            .disposed(by: priv.disposeBag)
        
        input.rightBarButtonTap?
            .bind(to: pushVC)
            .disposed(by: priv.disposeBag)
        
        input.riceButtonTap
            .bind(with: self) { owner, _ in
                owner.updateFeed(for: .rice, count: 1)
            }
            .disposed(by: priv.disposeBag)
        
        input.waterButtonTap
            .bind(with: self) { owner, _ in
                owner.updateFeed(for: .water, count: 1)
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
        priv.tamagotchi.accept(TGStaticStorage.info)
    }
    
    private func updateBubble(for bubbleUpdate: BubbleUpdate) -> String {
        return bubbleUpdate.message(nickname: priv.user.nickname)
    }
    
    private func updateFeed(for feedType: FeedType, count: Int) {
        var bubbleText: String
        
        switch feedType {
        case .rice:
            TGStorage.shared.info.rice += count
            bubbleText = self.updateBubble(for: .rice)
        case .water:
            TGStorage.shared.info.water += count
            bubbleText = self.updateBubble(for: .water)
        }
        
        self.setTamagotchi()
        self.priv.bubbleText.accept(bubbleText)
    }
    
}

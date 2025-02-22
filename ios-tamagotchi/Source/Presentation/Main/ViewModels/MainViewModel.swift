//
//  MainViewModel.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa
import RxGesture

final class MainViewModel: BaseViewModel {
    
    //MARK: - Input
    struct Input {
        let viewDidLoad: ControlEvent<Void>
        let viewWillAppear: ControlEvent<Bool>
        let rightBarButtonTap: ControlEvent<()>?
        let riceText: ControlProperty<String?>
        let waterText: ControlProperty<String?>
        let riceButtonTap: ControlEvent<Void>
        let waterButtonTap: ControlEvent<Void>
        let riceDidBeginEditing: ControlEvent<()>
        let waterDidBeginEditing: ControlEvent<()>
        let riceDidEndEditing: ControlEvent<()>
        let waterDidEndEditing: ControlEvent<()>
        let mainViewTapOrSwipeDown: ControlEvent<RxGestureRecognizer>
        let mainViewSwipeUp: ControlEvent<RxGestureRecognizer>
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: PublishRelay<String>
        let rightBarButtonImage: Observable<String>
        let bubbleText: PublishRelay<String>
        let tgImage: PublishRelay<String>
        let tgName: PublishRelay<String>
        let tgInfo: PublishRelay<String>
        let riceText: PublishRelay<String>
        let waterText: PublishRelay<String>
        let riceFormFocus: PublishRelay<Void>
        let showsKeyboard: PublishRelay<Bool>
        let transformView: PublishRelay<(TimeInterval, CGAffineTransform)>
        let pushVC: PublishRelay<Void>
    }
    
    //MARK: - Private
    private struct Private {
        let rightBarButtonImage = "person.circle"
        var user = BehaviorRelay(value: User())
        let tamagotchi = PublishRelay<Tamagotchi>()
        let bubbleText = PublishRelay<String>()
        let transformView = PublishRelay<(TimeInterval, CGAffineTransform)>()
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    deinit {
        print(self, #function)
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        print("transform")
        let navigationTitle = PublishRelay<String>()
        let rightBarButtonImage = Observable.just(priv.rightBarButtonImage)
        let bubbleText = PublishRelay<String>()
        let tgImage = PublishRelay<String>()
        let tgName = PublishRelay<String>()
        let tgInfo = PublishRelay<String>()
        let riceText = PublishRelay<String>()
        let waterText = PublishRelay<String>()
        let riceFormFocus = PublishRelay<Void>()
        let showsKeyboard = PublishRelay<Bool>()
        let transformView = PublishRelay<(TimeInterval, CGAffineTransform)>()
        let pushVC = PublishRelay<Void>()
        
        priv.user
            .debug("priv user")
            .map { "\($0.nickname)님의 다마고치" }
            .bind(to: navigationTitle)
            .disposed(by: priv.disposeBag)
        
        priv.tamagotchi
            .debug("priv tamagotchi")
            .bind(with: self) { owner, tamagotchi in
                tgImage.accept(tamagotchi.image)
                tgName.accept(tamagotchi.name)
                tgInfo.accept(tamagotchi.info)
            }
            .disposed(by: priv.disposeBag)
        
        priv.bubbleText
            .debug("priv bubbleText")
            .bind(to: bubbleText)
            .disposed(by: priv.disposeBag)
        
        priv.transformView
            .debug("priv transformView")
            .bind(to: transformView)
            .disposed(by: priv.disposeBag)
        
        input.viewDidLoad
            .debug("viewDidLoad")
            .bind(with: self) { owner, _ in
                owner.setUser()
                owner.setTamagotchi()
            }
            .disposed(by: priv.disposeBag)
        
        input.viewWillAppear
            .debug("viewWillAppear")
            .withUnretained(self)
            .map { $0.0.updateBubble(for: .enterView) }
            .bind(to: priv.bubbleText)
            .disposed(by: priv.disposeBag)
        
        input.rightBarButtonTap?
            .debug("rightBarButtonTap")
            .bind(to: pushVC)
            .disposed(by: priv.disposeBag)
        
        input.riceButtonTap
            .debug("riceButtonTap")
            .withLatestFrom(input.riceText)
            .bind(with: self) { owner, text in
                owner.updateFeed(for: .rice, input: text)
                if let text, !text.isEmpty { riceText.accept("") }
            }
            .disposed(by: priv.disposeBag)
        
        input.waterButtonTap
            .debug("waterButtonTap")
            .withLatestFrom(input.waterText)
            .bind(with: self) { owner, text in
                owner.updateFeed(for: .water, input: text)
                if let text, !text.isEmpty { waterText.accept("") }
            }
            .disposed(by: priv.disposeBag)
        
        input.riceDidBeginEditing
            .debug("riceDidBeginEditing")
            .bind(with: self) { owner, _ in
                owner.viewUp()
            }
            .disposed(by: priv.disposeBag)
        
        input.waterDidBeginEditing
            .debug("waterDidBeginEditing")
            .bind(with: self) { owner, _ in
                owner.viewUp()
            }
            .disposed(by: priv.disposeBag)
        
        input.riceDidEndEditing
            .debug("riceDidEndEditing")
            .bind(with: self) { owner, _ in
                owner.viewDown()
            }
            .disposed(by: priv.disposeBag)
        
        input.waterDidEndEditing
            .debug("waterDidEndEditing")
            .bind(with: self) { owner, _ in
                owner.viewDown()
            }
            .disposed(by: priv.disposeBag)
        
        input.mainViewTapOrSwipeDown
            .debug("mainViewTapOrSwipeDown")
            .when(.recognized)
            .map { !$0.isEnabled }
            .bind(to: showsKeyboard)
            .disposed(by: priv.disposeBag)
        
        input.mainViewSwipeUp
            .debug("mainViewSwipeUp")
            .when(.recognized)
            .bind(with: self, onNext: { owner, _ in
                riceFormFocus.accept(())
            })
            .disposed(by: priv.disposeBag)
        
        return Output(
            navigationTitle: navigationTitle,
            rightBarButtonImage: rightBarButtonImage,
            bubbleText: bubbleText,
            tgImage: tgImage,
            tgName: tgName,
            tgInfo: tgInfo,
            riceText: riceText,
            waterText: waterText,
            riceFormFocus: riceFormFocus,
            showsKeyboard: showsKeyboard,
            transformView: transformView,
            pushVC: pushVC
        )
    }
    
    private func setUser() {
        self.priv.user.accept(UserStaticStorage.info)
    }
    
    private func setTamagotchi() {
        self.priv.tamagotchi.accept(TGStaticStorage.info)
    }
    
    private func updateBubble(for bubbleUpdate: BubbleUpdate) -> String {
        return bubbleUpdate.message(nickname: priv.user.value.nickname)
    }
    
    private func updateFeed(for feedType: FeedType, input: String?) {
        print(#function, input)
        
        var count: Int = 0
        var bubbleText: String
        
        do {
            count = try feedType.validation(inputFeed: input)
        } catch {
            print(error)
            return
        }
        
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
    
    private func viewUp() {
        self.priv.transformView.accept((0.3, self.transform(y: -200)))
    }
    
    private func viewDown() {
        self.priv.transformView.accept((0.3, self.transform(y: 0)))
    }
    
    private func transform(y: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: 0, y: y)
    }
    
}

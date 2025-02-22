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
    struct Input {}
    
    //MARK: - Output
    struct Output {
        let navigationTitle: BehaviorRelay<String>
        let rightBarButtonImage: Observable<String>
    }
    
    //MARK: - Private
    private struct Private {
        var navigationTitle = ""
        let rightBarButtonImage = "person.circle"
        var user = User()
        var tamagotchi = Tamagotchi()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    //MARK: - Initializer Method
    init() {
        priv.user = getUser()
        priv.tamagotchi = getTamagotchi()
        priv.navigationTitle = "\(priv.user.nickname)의 다마고치"
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: priv.navigationTitle)
        let rightBarButtonImage = Observable.just(priv.rightBarButtonImage)
        
        return Output(
            navigationTitle: navigationTitle,
            rightBarButtonImage: rightBarButtonImage
        )
    }
    
    private func getUser() -> User {
        return UserStaticStorage.info
    }
    
    private func getTamagotchi() -> Tamagotchi {
        return TGStaticStorage.info
    }
    
}

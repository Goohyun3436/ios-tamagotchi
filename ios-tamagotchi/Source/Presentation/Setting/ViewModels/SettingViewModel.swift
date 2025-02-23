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
    struct Input {}
    
    //MARK: - Output
    struct Output {
        let navigationTitle: Observable<String>
        let menus: Observable<[SettingMenu]>
    }
    
    //MARK: - Private
    private struct Private {
        let navigationTitle = "설정"
        let user = UserStaticStorage.info
        var menus = [SettingMenu]()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    init() {
        self.priv.menus = SettingMenuType.allCases.map {
            SettingMenu(
                icon: $0.icon,
                title: $0.title,
                detailText: $0 == .userNickname ? self.priv.user.nickname : "",
                accessoryImage: $0.accessoryImage
            )
        }
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just(priv.navigationTitle)
        let menus = Observable.just(priv.menus)
        
        return Output(
            navigationTitle: navigationTitle,
            menus: menus
        )
    }
    
}

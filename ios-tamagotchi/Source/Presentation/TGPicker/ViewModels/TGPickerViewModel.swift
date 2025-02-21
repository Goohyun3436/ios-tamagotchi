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
        
    }
    
    //MARK: - Output
    struct Output {
        let navigationTitle: Observable<String>
        let items: BehaviorRelay<[TamagotchiThumbnail]>
    }
    
    //MARK: - Private
    private struct Private {
        let navigationTitle = "다마고치 선택하기"
        var tamagotchiTypes = TamagotchiType.activeCases
        let emptyTamagotchiTypes = Array(repeating: TamagotchiType.empty, count: 18)
        var tamagotchis = [TamagotchiThumbnail]()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    //MARK: - Initializer Method
    init() {
        priv.tamagotchiTypes.append(contentsOf: priv.emptyTamagotchiTypes)
        
        priv.tamagotchis = priv.tamagotchiTypes.map {
            TamagotchiThumbnail(image: $0.thumbnail, name: "  \($0.name)  ")
        }
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just(priv.navigationTitle)
        let items = BehaviorRelay(value: priv.tamagotchis)
        
        return Output(
            navigationTitle: navigationTitle,
            items: items
        )
    }
    
}

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
        let presentVC: PublishRelay<TamagotchiThumbnail>
    }
    
    //MARK: - Private
    private struct Private {
        let navigationTitle = "다마고치 선택하기"
        var tamagotchiTypes = TamagotchiType.activeCases
        let emptyTamagotchiTypes = Array(repeating: TamagotchiType.empty, count: 18)
        var tamagotchis = [TamagotchiThumbnail]()
        let disposeBag = DisposeBag()
    }
    
    //MARK: - Property
    private var priv = Private()
    
    //MARK: - Initializer Method
    init() {
        priv.tamagotchiTypes.append(contentsOf: priv.emptyTamagotchiTypes)
        
        priv.tamagotchis = priv.tamagotchiTypes.map {
            TamagotchiThumbnail(
                id: $0.index,
                image: $0.thumbnail,
                name: "  \($0.name)  ",
                intro: $0.intro
            )
        }
    }
    
    //MARK: - Method
    func transform(input: Input) -> Output {
        let navigationTitle = Observable.just(priv.navigationTitle)
        let tamagotchis = BehaviorRelay(value: priv.tamagotchis)
        let presentVC = PublishRelay<TamagotchiThumbnail>()
        
        input.tamagotchiTap
            .bind(with: self) { owner, tamagotchi in
                presentVC.accept(tamagotchi)
            }
            .disposed(by: priv.disposeBag)
        
        return Output(
            navigationTitle: navigationTitle,
            tamagotchis: tamagotchis,
            presentVC: presentVC
        )
    }
    
}

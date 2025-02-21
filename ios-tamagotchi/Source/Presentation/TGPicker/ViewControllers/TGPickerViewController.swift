//
//  TGPickerViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import RxSwift
import RxCocoa

class TGPickerViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = TGPickerView()
    private let viewModel = TGPickerViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup Method    
    override func setupBind() {
        let input = TGPickerViewModel.Input(
            tamagotchiTap: mainView.collectionView.rx.modelSelected(TamagotchiThumbnail.self)
        )
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.tamagotchis
            .bind(
                to: mainView.collectionView.rx.items(
                    cellIdentifier: TGCollectionViewCell.id,
                    cellType: TGCollectionViewCell.self
                ),
                curriedArgument: { item, element, cell in
                    cell.setData(info: element)
                }
            )
            .disposed(by: disposeBag)
        
        output.presentVC
            .bind(with: self) { owner, tamagotchi in
                owner.presentModal(tamagotchi)
            }
            .disposed(by: disposeBag)
    }
    
    private func presentModal(_ tamagotchi: TamagotchiThumbnail) {
        let vc = TGPickerModalViewController(
            tamagotchi: tamagotchi
        )
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
}

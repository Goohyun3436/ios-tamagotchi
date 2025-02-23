//
//  TGPickerModalViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import UIKit
import RxSwift
import RxCocoa

class TGPickerModalViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = TGPickerModalView()
    private let viewModel: TGPickerModalViewModel
    private let disposeBag = DisposeBag()
    
    //MARK: - Initializer Method
    init(viewModel: TGPickerModalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup Method
    override func setupBind() {
        let input = TGPickerModalViewModel.Input(
            cancelButtonTap: mainView.cancelButton.rx.tap,
            submitButtonTap: mainView.submitButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.image
            .bind(with: self) { owner, image in
                owner.mainView.tgThumbnailView.imageView.image = UIImage(named: image)
            }
            .disposed(by: disposeBag)
        
        output.name
            .bind(to: mainView.tgThumbnailView.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.intro
            .bind(to: mainView.introLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.cancelButtonTitle
            .bind(to: mainView.cancelButton.rx.title())
            .disposed(by: disposeBag)
        
        output.submitButtonTitle
            .bind(to: mainView.submitButton.rx.title())
            .disposed(by: disposeBag)
        
        output.dismissVC
            .bind(with: self) { owner, _ in
                owner.dismissVC()
            }
            .disposed(by: disposeBag)
        
        output.rootVC
            .bind(with: self) { owner, vc in
                owner.rootVC(vc)
            }
            .disposed(by: disposeBag)
    }
    
}

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
    private let viewModel = TGPickerModalViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK: - Initializer Method
    init(tamagotchi: TamagotchiThumbnail) {
        super.init(nibName: nil, bundle: nil)
        setupBind(tamagotchi)
    }
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup Method
    private func setupBind(_ tamagotchi: TamagotchiThumbnail) {
        let input = TGPickerModalViewModel.Input(
            tamagotchi: tamagotchi,
            cancelButtonTap: mainView.cancelButton.rx.tap,
            startButtonTap: mainView.startButton.rx.tap
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
        
        output.startButtonTitle
            .bind(to: mainView.startButton.rx.title())
            .disposed(by: disposeBag)
        
        output.dismissVC
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.pushVC
            .bind(with: self) { owner, _ in
                owner.moveToMain()
            }
            .disposed(by: disposeBag)
    }
    
    private func moveToMain() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first
        else { return }

        window.rootViewController = MainViewController()
    }
    
}

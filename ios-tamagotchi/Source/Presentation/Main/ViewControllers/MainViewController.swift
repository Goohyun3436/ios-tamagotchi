//
//  MainViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class MainViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = MainView()
    private let viewModel = MainViewModel()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        let input = MainViewModel.Input(
            viewDidLoad: rx.viewDidLoad,
            viewWillAppear: rx.viewWillAppear,
            viewWillDisappear: rx.viewWillDisappear,
            rightBarButtonTap: navigationItem.rightBarButtonItem?.rx.tap,
            riceText: mainView.riceForm.textField.rx.text,
            waterText: mainView.waterForm.textField.rx.text,
            riceButtonTap: mainView.riceForm.button.rx.tap,
            waterButtonTap: mainView.waterForm.button.rx.tap,
            riceDidBeginEditing: mainView.riceForm.textField.rx.controlEvent(.editingDidBegin),
            waterDidBeginEditing: mainView.waterForm.textField.rx.controlEvent(.editingDidBegin),
            riceDidEndEditing: mainView.riceForm.textField.rx.controlEvent(.editingDidEnd),
            waterDidEndEditing: mainView.waterForm.textField.rx.controlEvent(.editingDidEnd),
            mainViewTapOrSwipeDown: mainView.rx.anyGesture(.tap(), .swipe(direction: .down)),
            mainViewSwipeUp: mainView.rx.anyGesture(.swipe(direction: .up))
        )
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.rightBarButtonImage
            .bind(with: self) { owner, image in
                owner.navigationItem.rightBarButtonItem?.image = UIImage(systemName: image)
            }
            .disposed(by: disposeBag)
        
        output.bubbleText
            .bind(to: mainView.bubbleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tgImage
            .bind(with: self) { owner, image in
                owner.mainView.tgThumbnailView.imageView.image = UIImage(named: image)
            }
            .disposed(by: disposeBag)
        
        output.tgName
            .bind(to: mainView.tgThumbnailView.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tgInfo
            .bind(to: mainView.tgInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.riceText
            .bind(to: mainView.riceForm.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.waterText
            .bind(to: mainView.waterForm.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.riceFormFocus
            .bind(with: self) { owner, _ in
                owner.mainView.riceForm.textField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        output.endEditing
            .bind(with: self) { owner, force in
                owner.view.endEditing(force)
            }
            .disposed(by: disposeBag)
        
        output.transformView
            .bind(with: self) { owner, config in
                owner.animationView(config)
            }
            .disposed(by: disposeBag)
        
        output.alert
            .bind(with: self) { owner, alert in
                owner.presentAlert(alert)
            }
            .disposed(by: disposeBag)
        
        output.pushVC
            .bind(with: self) { owner, vc in
                owner.pushVC(vc)
            }
            .disposed(by: disposeBag)
    }
    
    private func animationView(_ config: (TimeInterval, CGAffineTransform)) {
        let (duration, transform) = config
        
        UIView.animate(withDuration: duration) {
            self.view.transform = transform
        }
    }
    
}

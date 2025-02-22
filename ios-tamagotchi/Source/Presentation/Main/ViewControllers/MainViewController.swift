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
        navigationItem.backButtonTitle = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print(self, #function)
    }
    
    //MARK: - Setup Method    
    override func setupBind() {
        print("setupBind")
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        let input = MainViewModel.Input(
            viewDidLoad: rx.viewDidLoad,
            viewWillAppear: rx.viewWillAppear,
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
            .debug("navigationTitle")
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.rightBarButtonImage
            .debug("rightBarButtonImage")
            .bind(with: self) { owner, image in
                owner.navigationItem.rightBarButtonItem?.image = UIImage(systemName: image)
            }
            .disposed(by: disposeBag)
        
        output.bubbleText
            .debug("bubbleText")
            .bind(to: mainView.bubbleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tgImage
            .debug("tgImage")
            .bind(with: self) { owner, image in
                owner.mainView.tgThumbnailView.imageView.image = UIImage(named: image)
            }
            .disposed(by: disposeBag)
        
        output.tgName
            .debug("tgName")
            .bind(to: mainView.tgThumbnailView.nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.tgInfo
            .debug("tgInfo")
            .bind(to: mainView.tgInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.riceText
            .debug("riceText")
            .bind(to: mainView.riceForm.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.waterText
            .debug("waterText")
            .bind(to: mainView.waterForm.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.riceFormFocus
            .debug("riceFormFocus")
            .bind(with: self) { owner, _ in
                owner.mainView.riceForm.textField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        output.showsKeyboard
            .debug("showsKeyboard")
            .bind(with: self) { owner, show in
                owner.view.endEditing(show)
            }
            .disposed(by: disposeBag)
        
        output.transformView
            .debug("transformView")
            .bind(with: self) { owner, config in
                owner.animationView(config)
            }
            .disposed(by: disposeBag)
        
        output.pushVC
            .debug("pushVC")
            .bind(with: self) { owner, _ in
                owner.moveToSetting()
            }
            .disposed(by: disposeBag)
    }
    
    private func moveToSetting() {
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first
        else { return }

        window.rootViewController = SettingViewController()
        
//        navigationController?.pushViewController(
//            SettingViewController(),
//            animated: true
//        )
    }
    
    private func animationView(_ config: (TimeInterval, CGAffineTransform)) {
        let (duration, transform) = config
        
        UIView.animate(withDuration: duration) {
            self.view.transform = transform
        }
    }
    
}

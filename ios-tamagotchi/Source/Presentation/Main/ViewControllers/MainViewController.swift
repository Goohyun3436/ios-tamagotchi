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
        mainView.riceForm.textField.delegate = self
        mainView.waterForm.textField.delegate = self
    }
    
    //MARK: - Setup Method
    override func setupActions() {
    }
    
    override func setupBind() {
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        let input = MainViewModel.Input(
            viewDidLoad: rx.viewDidLoad,
            viewWillAppear: rx.viewWillAppear,
            rightBarButtonTap: navigationItem.rightBarButtonItem?.rx.tap,
            riceText: mainView.riceForm.textField.rx.text,
            waterText: mainView.waterForm.textField.rx.text,
            riceButtonTap: mainView.riceForm.button.rx.tap,
            waterButtonTap: mainView.waterForm.button.rx.tap,
            mainViewTapOrSwipe: mainView.rx.anyGesture(.tap(
                configuration: { rec, _ in
                    rec.cancelsTouchesInView = false
                }), .swipe(direction: .down))
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
        
        output.showsKeyboard
            .bind(with: self) { owner, show in
                owner.view.endEditing(show)
            }
            .disposed(by: disposeBag)
        
        output.pushVC
            .bind(with: self) { owner, _ in
                owner.moveToSetting()
            }
            .disposed(by: disposeBag)
    }
    
    private func moveToSetting() {
        navigationController?.pushViewController(
            SettingViewController(),
            animated: true
        )
    }
    
}

//MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            let transform = CGAffineTransform(translationX: 0, y: -200)
            self.view.transform = transform
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            let transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.transform = transform
        }
    }
    
}

//
//  SettingNicknameViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class SettingNicknameViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = SettingNicknameView()
    private let viewModel: SettingNicknameViewModel
    private let disposeBag = DisposeBag()
    
    //MARK: - Initializer Method
    init(viewModel: SettingNicknameViewModel) {
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
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        let input = SettingNicknameViewModel.Input(
            viewDidAppear: rx.viewDidAppear,
            mainViewTap: mainView.rx.anyGesture(.tap()),
            nickname: mainView.textField.rx.text,
            editingDidEndOnExit: mainView.textField.rx.controlEvent(.editingDidEndOnExit),
            saveButtonTap: navigationItem.rightBarButtonItem?.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.rightBarButtonTitle
            .bind(to: navigationItem.rightBarButtonItem!.rx.title)
            .disposed(by: disposeBag)
        
        output.textFieldPlaceholder
            .bind(to: mainView.textField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.nickname
            .bind(to: mainView.textField.rx.text)
            .disposed(by: disposeBag)
        
        output.alert
            .bind(with: self) { owner, alert in
                owner.presentAlert(alert)
            }
            .disposed(by: disposeBag)
        
        output.showsKeyboard
            .bind(with: self) { owner, show in
                owner.textFieldResponder(show)
            }
            .disposed(by: disposeBag)
        
        output.popVC
            .bind(with: self) { owner, _ in
                owner.popVC()
            }
            .disposed(by: disposeBag)
    }
    
    private func textFieldResponder(_ show: Bool) {
        if show {
            self.mainView.textField.becomeFirstResponder()
        } else {
            self.mainView.textField.resignFirstResponder()
        }
    }
    
}

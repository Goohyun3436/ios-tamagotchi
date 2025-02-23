//
//  SettingNicknameViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingNicknameViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = SettingNicknameView()
    private let viewModel = SettingViewModel()
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
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem?.title = "저장"
        mainView.textField.placeholder = "대장님 이름을 알려주세요!"
    }
    
}

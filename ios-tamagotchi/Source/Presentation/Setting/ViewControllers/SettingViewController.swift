//
//  SettingViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = SettingView()
    private let viewModel = SettingViewModel()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup Method
    override func setupActions() {}
    
    override func setupBind() {}
    
}

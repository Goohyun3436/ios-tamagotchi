//
//  TamagotchiPickerViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit

class TamagotchiPickerViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = TamagotchiPickerView()
    private let viewModel = TamagotchiPickerViewModel()
    
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

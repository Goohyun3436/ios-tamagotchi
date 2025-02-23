//
//  SettingViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = SettingView()
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
        let input = SettingViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.menus
            .bind(
                to: mainView.tableView.rx.items(
                    cellIdentifier: SettingTableViewCell.id,
                    cellType: SettingTableViewCell.self
                ),
                curriedArgument: { row, element, cell in
                    cell.setData(element)
                }
            )
            .disposed(by: disposeBag)
    }
    
}

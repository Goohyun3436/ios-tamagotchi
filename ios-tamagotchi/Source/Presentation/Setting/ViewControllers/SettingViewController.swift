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
        let input = SettingViewModel.Input(
            menuTap: mainView.tableView.rx.modelSelected(SettingMenu.self)
        )
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
        
        output.resignAlert
            .bind(with: self, onNext: { owner, alert in
                owner.presentAlertWithCancel(alert)
            })
            .disposed(by: disposeBag)
        
        output.pushVC
            .bind(with: self) { owner, vc in
                owner.pushVC(vc)
            }
            .disposed(by: disposeBag)
        
        output.rootVC
            .bind(with: self) { owner, vc in
                owner.rootVC(vc)
            }
            .disposed(by: disposeBag)
    }
    
}

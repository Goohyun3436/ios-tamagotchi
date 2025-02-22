//
//  MainViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import RxSwift
import RxCocoa

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
    override func setupActions() {
    }
    
    override func setupBind() {
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        let input = MainViewModel.Input(
            viewWillAppear: self.rx.viewWillAppear,
            rightBarButtonTap: self.navigationItem.rightBarButtonItem?.rx.tap
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
        
        output.pushVC
            .bind(with: self) { owner, _ in
                owner.moveToSetting()
            }
            .disposed(by: disposeBag)
        
        
        mainView.bubbleImageView.image = UIImage(named: "bubble")
        mainView.tgThumbnailView.imageView.image = UIImage(named: "1-1")
        mainView.tgThumbnailView.nameLabel.text = "  따끔따끔 다마고치  "
        mainView.tgExpLabel.text = "LV10 · 밥알 8888888888888888개 · 물방울 888888888888888888888888개"
    }
    
    private func moveToSetting() {
        navigationController?.pushViewController(
            SettingViewController(),
            animated: true
        )
    }
    
}

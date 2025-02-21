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
        let input = MainViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.navigationTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.rightBarButtonImage
            .bind(with: self) { owner, image in
                owner.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: UIImage(systemName: image),
                    style: .plain,
                    target: owner,
                    action: nil
                )
            }
            .disposed(by: disposeBag)
        
        
        mainView.bubbleImageView.image = UIImage(named: "bubble")
        mainView.bubbleLabel.text = "대장님 오늘 과제 하셨어용?"
    }
    
}

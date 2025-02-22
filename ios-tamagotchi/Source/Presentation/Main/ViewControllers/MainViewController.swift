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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        mainView.bubbleLabel.text = "대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?대장님 오늘 과제 하셨어용?"
        mainView.tgThumbnailView.imageView.image = UIImage(named: "1-1")
        mainView.tgThumbnailView.nameLabel.text = "  따끔따끔 다마고치  "
        mainView.tgExpLabel.text = "LV10 · 밥알 8888888888888888개 · 물방울 888888888888888888888888개"
    }
    
}

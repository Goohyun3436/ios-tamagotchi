//
//  TGPickerModalViewController.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import UIKit
import RxSwift
import RxCocoa

class TGPickerModalViewController: BaseViewController {
    
    //MARK: - Property
    private let mainView = TGPickerModalView()
    private let viewModel = TGPickerModalViewModel()
    private let disposeBag = DisposeBag()
    
    //MARK: - Override Method
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup Method
    override func setupActions() {}
    
    override func setupBind() {
        mainView.tgThumbnailView.imageView.image = UIImage(named: "1-1")
        mainView.tgThumbnailView.nameLabel.text = "  테스트 다마고치  "
        mainView.introLabel.text = "저는 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        mainView.cancelButton.setTitle("취소", for: .normal)
        mainView.startButton.setTitle("시작하기", for: .normal)
    }
    
}

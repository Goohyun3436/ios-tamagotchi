//
//  TGPickerModalView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import UIKit
import SnapKit

final class TGPickerModalView: BaseView {
    
    //MARK: - UI Property
    private let wrap = UIView()
    let tgThumbnailView = TGThumbnailView()
    private let divider = RectView()
    let introLabel = UILabel()
    private let buttonWrap = UIStackView()
    let cancelButton = UIButton()
    let startButton = UIButton()
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(wrap)
        
        [tgThumbnailView, divider, introLabel, buttonWrap].forEach {
            wrap.addSubview($0)
        }
        
        [cancelButton, startButton].forEach {
            buttonWrap.addArrangedSubview($0)
        }
    }
    
    override func setupConstraints() {
        wrap.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(50)
        }
        
        tgThumbnailView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(tgThumbnailView.snp.bottom).offset(24)
            make.bottom.equalTo(introLabel.snp.top).offset(-24)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
        
        introLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        buttonWrap.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        buttonWrap.axis = .horizontal
        buttonWrap.distribution = .fillEqually
    }
    
    override func setupAttributes() {
        backgroundColor = AppColor.overlay
        wrap.clipsToBounds = true
        wrap.layer.cornerRadius = 6
        wrap.backgroundColor = AppColor.backgroundColor
        introLabel.numberOfLines = 0
        introLabel.textAlignment = .center
        introLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        cancelButton.backgroundColor = AppColor.secondaryBackgroundColor
        cancelButton.setTitleColor(AppColor.label, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        startButton.backgroundColor = AppColor.backgroundColor
        startButton.setTitleColor(AppColor.label, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    }
    
}

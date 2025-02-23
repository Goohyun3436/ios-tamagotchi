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
    let submitButton = UIButton()
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(wrap)
        
        [tgThumbnailView, divider, introLabel, buttonWrap].forEach {
            wrap.addSubview($0)
        }
        
        [cancelButton, submitButton].forEach {
            buttonWrap.addArrangedSubview($0)
        }
    }
    
    override func setupConstraints() {
        let modalHMargin: Double = 50
        let modalHInset: Double = 40
        let dividerVMargin: Double = 24
        
        wrap.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(modalHMargin)
        }
        
        tgThumbnailView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(tgThumbnailView.snp.bottom).offset(dividerVMargin)
            make.bottom.equalTo(introLabel.snp.top).offset(-dividerVMargin)
            make.horizontalEdges.equalToSuperview().inset(modalHInset)
            make.height.equalTo(1)
        }
        
        introLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(modalHInset)
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
        introLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        cancelButton.backgroundColor = AppColor.tertiaryBackground
        cancelButton.setTitleColor(AppColor.label, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        submitButton.backgroundColor = AppColor.backgroundColor
        submitButton.setTitleColor(AppColor.label, for: .normal)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
}

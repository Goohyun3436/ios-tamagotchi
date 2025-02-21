//
//  TGThumbnailView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import UIKit
import SnapKit

final class TGThumbnailView: BaseView {
    
    //MARK: - UI Property
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    //MARK: - Setup Method
    override func setupUI() {
        [imageView, nameLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(imageView.snp.width).multipliedBy(1.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupAttributes() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 4
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = AppColor.label.cgColor
        nameLabel.backgroundColor = AppColor.secondaryBackgroundColor
        nameLabel.textColor = AppColor.label
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
}

//
//  SettingTableViewCell.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit
import SnapKit

class SettingTableViewCell: BaseTableViewCell {
    
    //MARK: - UI Property
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let accessoryImageView = UIImageView()
    
    //MARK: - Property
    static let id = "SettingTableViewCell"
    
    //MARK: - Method
    func setData(_ menu: SettingMenu) {
        iconView.image = UIImage(systemName: menu.icon)
        titleLabel.text = menu.title
        detailLabel.text = menu.detailText
        accessoryImageView.image = UIImage(systemName: menu.accessoryImage)
    }
    
    //MARK: - Setup Method
    override func setupUI() {
        [iconView, titleLabel, detailLabel, accessoryImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        let margin: CGFloat = 16
        let iconSize: CGFloat = 20
        let accessorySize = CGSize(width: 10, height: 16)
        
        iconView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(margin)
            make.size.equalTo(iconSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(iconView.snp.trailing).offset(margin)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(accessoryImageView.snp.leading).offset(-4)
        }
        
        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(margin)
            make.width.equalTo(accessorySize.width)
            make.height.equalTo(accessorySize.height)
        }
    }
    
    override func setupAttributes() {
        iconView.tintColor = AppColor.label
        titleLabel.textColor = AppColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        detailLabel.textColor = AppColor.secondaryLabel
        detailLabel.font = UIFont.systemFont(ofSize: 13)
        accessoryImageView.tintColor = AppColor.secondaryLabel
    }
    
}

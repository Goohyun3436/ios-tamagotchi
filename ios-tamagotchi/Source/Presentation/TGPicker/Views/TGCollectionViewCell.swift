//
//  TGCollectionViewCell.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import UIKit
import SnapKit

final class TGCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UI Property
    private let tgThumbnailView = TGThumbnailView()
    
    //MARK: - Property
    static let id = "TGCollectionViewCell"
    
    //MARK: - Method
    func setData(info: TamagotchiThumbnail) {
        tgThumbnailView.imageView.image = UIImage(named: info.image)
        tgThumbnailView.nameLabel.text = info.name
    }
    
    //MARK: - Setup Method
    override func setupUI() {
        contentView.addSubview(tgThumbnailView)
    }
    
    override func setupConstraints() {
        tgThumbnailView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func setupAttributes() {
        backgroundColor = UIColor.red
    }
    
}

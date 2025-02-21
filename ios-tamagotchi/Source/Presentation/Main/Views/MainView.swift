//
//  MainView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    //MARK: - UI Property
    let bubbleImageView = UIImageView()
    let bubbleLabel = UILabel()
    let tgThumbnailView = TGThumbnailView()
    let tgExpLabel = UILabel()
    
    //MARK: - Setup Method
    override func setupUI() {
        bubbleImageView.addSubview(bubbleLabel)
        
        [bubbleImageView, tgThumbnailView, tgExpLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        let bubbleWidth: Double = UIScreen.main.bounds.width * 0.6
        let bubbleHeight: Double = bubbleWidth * (71.0 / 111.0)
        let bubbleTailHeight: Double = bubbleHeight * 0.045
        let bubbleInset: Double = 4
        
        bubbleImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(bubbleWidth)
            make.height.equalTo(bubbleHeight)
        }
        
        bubbleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-bubbleTailHeight)
            make.top.leading.greaterThanOrEqualToSuperview().offset(bubbleInset)
            make.trailing.bottom.lessThanOrEqualToSuperview().offset(-bubbleInset)
        }
        
        tgThumbnailView.snp.makeConstraints { make in
            make.top.equalTo(bubbleImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalTo(bubbleWidth)
        }
        
        tgExpLabel.snp.makeConstraints { make in
            make.top.equalTo(tgThumbnailView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(16)
        }
    }
    
    override func setupAttributes() {
        bubbleImageView.contentMode = .scaleAspectFit
        bubbleLabel.numberOfLines = 0
        bubbleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        tgExpLabel.numberOfLines = 0
        tgExpLabel.textAlignment = .center
        tgExpLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
}

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
    let bubbleImageView = UIImageView(image: UIImage(named: "bubble"))
    let bubbleLabel = UILabel()
    let tgThumbnailView = TGThumbnailView()
    let tgInfoLabel = UILabel()
    private let formWrap = UIStackView()
    let riceForm = FeedFormView(feedType: .rice)
    let waterForm = FeedFormView(feedType: .water)
    
    override func layoutSubviews() {
        riceForm.textField.setupBorderBottom(borderWidth: 1)
        waterForm.textField.setupBorderBottom(borderWidth: 1)
    }
    
    //MARK: - Setup Method
    override func setupUI() {
        bubbleImageView.addSubview(bubbleLabel)
        
        [riceForm, waterForm].forEach {
            formWrap.addArrangedSubview($0)
        }
        
        [bubbleImageView, tgThumbnailView, tgInfoLabel, formWrap].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        let bubbleWidth: Double = UIScreen.main.bounds.width * 0.6
        let bubbleHeight: Double = bubbleWidth * (71.0 / 111.0)
        let bubbleTailHeight: Double = bubbleHeight * 0.045
        let bubbleInset: Double = 8
        
        let formHeight: Double = 34
        let formMargin: Double = 16
        let formButtonWidth: Double = 80
        
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
        
        tgInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(tgThumbnailView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        formWrap.snp.makeConstraints { make in
            make.top.equalTo(tgInfoLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(bubbleWidth)
            make.height.equalTo(formHeight * 2 + formMargin)
        }
        formWrap.axis = .vertical
        formWrap.spacing = formMargin
        formWrap.distribution = .fillEqually
        
        [riceForm.button, waterForm.button].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(formButtonWidth)
            }
        }
    }
    
    override func setupAttributes() {
        self.isUserInteractionEnabled = true
        bubbleImageView.contentMode = .scaleAspectFit
        bubbleLabel.numberOfLines = 0
        bubbleLabel.textAlignment = .center
        bubbleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        tgInfoLabel.numberOfLines = 0
        tgInfoLabel.textAlignment = .center
        tgInfoLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
}

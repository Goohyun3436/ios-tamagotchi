//
//  FeedButton.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import UIKit

final class FeedButton: UIButton {
    
    init(feedType: FeedType) {
        super.init(frame: .zero)
        self.setImage(UIImage(systemName: feedType.buttonImage), for: .normal)
        self.setTitle(feedType.buttonTitle, for: .normal)
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = AppColor.label.cgColor
        self.tintColor = AppColor.label
        self.setTitleColor(AppColor.label, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

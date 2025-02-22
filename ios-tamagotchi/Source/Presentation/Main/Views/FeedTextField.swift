//
//  FeedTextField.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import UIKit

final class FeedTextField: UITextField {
    override var placeholder: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [.foregroundColor: AppColor.secondaryLabel]
            )
        }
    }
    
    init(feedType: FeedType) {
        super.init(frame: .zero)
        self.placeholder = feedType.textFieldPlaceholder
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.textColor = AppColor.label
    }
    
    func setupBorderBottom(borderWidth: CGFloat) {
        guard self.frame.width != 0.0 && self.frame.height != 0.0 else { return }
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
        bottomBorder.backgroundColor = AppColor.label.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomBorder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

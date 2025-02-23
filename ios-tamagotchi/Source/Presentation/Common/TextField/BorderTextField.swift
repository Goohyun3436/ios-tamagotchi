//
//  BorderTextField.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit

class BorderTextField: UITextField {
    override var placeholder: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(
                string: self.placeholder ?? "",
                attributes: [.foregroundColor: AppColor.secondaryLabel]
            )
        }
    }
    
    init(placeholder: String? = nil) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        self.textColor = AppColor.label
        
        DispatchQueue.main.async {
            print("test")
            self.setupBorderBottom()
        }
    }
    
    private func setupBorderBottom(borderWidth: CGFloat = 1.0) {
        print(self.frame)
        guard self.frame.width != 0.0 && self.frame.height != 0.0 else { return }
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
        bottomBorder.backgroundColor = AppColor.label.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomBorder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  FeedFormView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import UIKit

final class FeedFormView: UIStackView {
    
    let textField: FeedTextField
    let button: FeedButton
    
    init(feedType: FeedType) {
        self.textField = FeedTextField(feedType: feedType)
        self.button = FeedButton(feedType: feedType)
        
        super.init(frame: .zero)
        
        [textField, button].forEach {
            self.addArrangedSubview($0)
        }
        
        self.axis = .horizontal
        self.spacing = 16
        self.textField.keyboardType = .numberPad
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

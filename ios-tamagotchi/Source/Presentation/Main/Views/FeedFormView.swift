//
//  FeedFormView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import UIKit

final class FeedFormView: UIStackView {
    
    var textField: FeedTextField
    var button: FeedButton
    
    init(feedType: FeedType) {
        self.textField = FeedTextField(feedType: feedType)
        self.button = FeedButton(feedType: feedType)
        
        //refactor point: super.init 호출 전에 인스턴스 프로퍼티 초기화 해줘도 되는지 확인 필요
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

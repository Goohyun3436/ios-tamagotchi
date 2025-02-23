//
//  FeedTextField.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import UIKit

final class FeedTextField: BorderTextField {
    
    init(feedType: FeedType) {
        super.init(placeholder: feedType.textFieldPlaceholder)
    }
    
}

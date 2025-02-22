//
//  MainPresent.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import Foundation

enum FeedType: String {
    case rice = "밥"
    case water = "물"
    
    var textFieldPlaceholder: String {
        return self.rawValue + "주세용"
    }
    
    var buttonImage: String {
        switch self {
        case .rice:
            return "drop.circle"
        case .water:
            return "leaf.circle"
        }
    }
    
    var buttonTitle: String {
        return " \(self.rawValue)먹기"
    }
}

enum BubbleUpdateType {
    case enterView
    case rice
    case water
}

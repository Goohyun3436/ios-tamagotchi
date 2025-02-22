//
//  MainPresent.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import Foundation

enum FeedValidationError: Error {
    case emptyString
    case isNotInt
    case outOfRange
}

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
    
    var range: [Int] {
        switch self {
        case .rice:
            return [1, 99]
        case .water:
            return [1, 49]
        }
    }
    
    func validation(inputFeed: String?) throws -> Int {
        guard var inputFeed else {
            throw FeedValidationError.emptyString //alert: 잘못된 입력
        }
        
        if inputFeed.isEmpty { inputFeed = "1" }
        
        guard let count = Int(inputFeed) else {
            throw FeedValidationError.isNotInt //alert: 숫자 입력
        }
        
        guard count >= self.range[0] && count <= self.range[1] else {
            throw FeedValidationError.outOfRange //alert: 범위밖
        }
        
        return count
    }
}

enum BubbleUpdate {
    case enterView
    case rice
    case water
    
    func message(nickname: String) -> String {
        switch self {
        case .enterView:
            return [
                "\(nickname)님 지금 잠이 오세여?",
                "오늘도 저는 귀엽네요, \(nickname)님? \(nickname)님?",
                "심심해요, \(nickname)님~ 블로그는 언제 쓸 거예요!"
            ].randomElement()!
        case .rice:
            return [
                "\(nickname)님, 밥 주셨다니! 이건 사랑 아닙니까?",
                "\(nickname)님, 요리사세요?",
                "더 주세요, \(nickname)님! 밥 내 놔!"
            ].randomElement()!
        case .water:
            return [
                "물이 들어오니 생기가 도네요! \(nickname)님 최고!",
                "\(nickname)님 물이 짜다!",
                "물 더 주세요, \(nickname)님!"
            ].randomElement()!
        }
    }
}

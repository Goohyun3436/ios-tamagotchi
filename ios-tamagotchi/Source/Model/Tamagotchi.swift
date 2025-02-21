//
//  Tamagotchi.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import Foundation

enum TamagotchiType: String, CaseIterable {
    static var activeCases: [TamagotchiType] = TamagotchiType.allCases.dropLast()
    
    case cactus = "따끔따끔"
    case sun = "방실방실"
    case star = "반짝반짝"
    case empty = "준비중이에요"
    
    var name: String {
        switch self {
        case .empty:
            return self.rawValue
        default:
            return self.rawValue + " 다마고치"
        }
    }
    
    var thumbnail: String {
        switch self {
        case .empty:
            return "noImage"
        default:
            return "\(self.index + 1)-6"
        }
    }
    
    func image(exp: Int) -> String {
        return "\(self.index + 1)-\(self.level(exp: exp))"
    }
    
    func level(exp: Int) -> Int {
        guard 0 <= exp else { return 0 }
        
        guard exp > 10 else { return 1 }
        
        return exp / 10
    }
    
    private var index: Int {
        guard let index = TamagotchiType.allCases.firstIndex(of: self) else {
            return 0
        }
        
        return index
    }
}

struct Tamagotchi {
    let type: TamagotchiType
    let rice: Int = 0
    let water: Int = 0
    var exp: Int {
        return rice / 5 + water / 2
    }
}

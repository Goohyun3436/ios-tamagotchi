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
    
    private var characteristic: String {
        switch self {
        case .cactus:
            return "키는 10cm 몸무게는 50g이에용..\n성격은 소심해용..\n말을 많이 걸어주면 좋겠어용.."
        case .sun:
            return "키는 100km 몸무게는 150톤이에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은 있답니당"
        case .star:
            return "키는 300km 몸무게는 200톤이에용\n성격이 급하고 말이 빠르답니당!\n잘 클테니까 밥이랑 물을 빨리빨리 주면 좋겠어용"
        case .empty:
            return ""
        }
    }
    
    var intro: String {
        switch self {
        case .empty:
            return ""
        default:
            return "저는 \(self.name)입니당 \(self.characteristic) \(self.rawValue)!"
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
    
    var index: Int {
        guard let index = TamagotchiType.allCases.firstIndex(of: self) else {
            return 0
        }
        
        return index
    }
}

struct Tamagotchi: Codable {
    var id: Int = TamagotchiType.empty.index
    var rice: Int = 0
    var water: Int = 0
    var exp: Int {
        return rice / 5 + water / 2
    }
}

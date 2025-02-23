//
//  TGStorage.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/21/25.
//

import Foundation

final class TGStorage {
    
    static let shared = TGStorage()
    
    private init() {}
    
    @UserDefaultsJSON(key: .tamagotchi, empty: Tamagotchi())
    var info {
        didSet {
            TGStaticStorage.info = info
        }
    }
    
    func load() {
        TGStaticStorage.info = self.info
    }
    
}

enum TGStaticStorage {
    fileprivate(set) static var info = Tamagotchi()
}

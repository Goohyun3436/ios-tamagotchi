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
            print("update", TGStaticStorage.info)
        }
    }
    
    func load() {
        TGStaticStorage.info = self.info
        print("load", TGStaticStorage.info)
    }
    
}

enum TGStaticStorage {
    fileprivate(set) static var info = Tamagotchi()
}

//
//  UserStorage.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import Foundation

final class UserStorage {
    
    static let shared = UserStorage()
    
    private init() {}
    
    @UserDefaultsJSON(key: .user, empty: User())
    var info {
        didSet {
            UserStaticStorage.info = info
            print("update", UserStaticStorage.info)
        }
    }
    
    func load() {
        UserStaticStorage.info = self.info
        print("load", UserStaticStorage.info)
    }
    
}

enum UserStaticStorage {
    fileprivate(set) static var info = User()
}

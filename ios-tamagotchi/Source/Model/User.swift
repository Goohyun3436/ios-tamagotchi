//
//  User.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/22/25.
//

import Foundation

fileprivate let nicknameRange = [2, 6]

struct User: Codable {
    var nickname: String = "대장"
    
    static func nicknameValidation(_ input: String) throws -> String {
        let nickname = input.trimmingCharacters(in: .whitespaces)
        
        guard !nickname.isEmpty else {
            throw NicknameValidationError.emptyString
        }
        
        guard nicknameRange[0] <= nickname.count && nickname.count <= nicknameRange[1] else {
            throw NicknameValidationError.outOfRange
        }
        
        return nickname
    }
}

enum NicknameValidationError: Error {
    case emptyString
    case outOfRange
    
    var title: String {
        return "변경 실패"
    }
    
    var message: String {
        switch self {
        case .emptyString:
            return "대장 이름을 입력해주세용"
        case .outOfRange:
            return "대장 이름은 \(nicknameRange[0])~\(nicknameRange[1])글자로 설정해주세용"
        }
    }
}

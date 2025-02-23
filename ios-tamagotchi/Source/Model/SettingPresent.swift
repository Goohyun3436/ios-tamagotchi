//
//  SettingPresent.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit

enum SettingMenuType: CaseIterable {
    case userNickname
    case tgPicker
    case resign
    
    var icon: String {
        switch self {
        case .userNickname:
            return "pencil"
        case .tgPicker:
            return "moon.fill"
        case .resign:
            return "arrow.clockwise"
        }
    }
    
    var title: String {
        switch self {
        case .userNickname:
            return "내 이름 설정하기"
        case .tgPicker:
            return "다마고치 변경하기"
        case .resign:
            return "데이터 초기화"
        }
    }
    
    var accessoryImage: String {
        return "chevron.right"
    }
}

struct SettingMenu {
    let type: SettingMenuType
    let icon: String
    let title: String
    var detailText: String
    let accessoryImage: String
}

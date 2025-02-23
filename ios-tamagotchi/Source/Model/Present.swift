//
//  Present.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import Foundation

struct AlertInfo {
    let title: String?
    let message: String?
    var submitHandler: (() -> Void)? = nil
}

//
//  AppAppearance.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit

enum AppColor {
    static let backgroundColor = UIColor.appBackground
    static let secondaryBackgroundColor = UIColor.appSecondaryBackground
    static let tertiaryBackground = UIColor.appTertiaryBackground
    static let overlay = UIColor.appOverlay
    static let label = UIColor.appLabel
    static let secondaryLabel = UIColor.appSecondaryLabel
    static let black = UIColor.black
    static let white = UIColor.white
}

final class AppAppearance {
    
    private init() {}
    
    static func setupAppearance() {
        let appearanceN = UINavigationBarAppearance()
        appearanceN.configureWithTransparentBackground()
        appearanceN.backgroundColor = AppColor.backgroundColor
        appearanceN.titleTextAttributes = [.foregroundColor: AppColor.label, .font: UIFont.systemFont(ofSize: 15, weight: .bold)]
        appearanceN.largeTitleTextAttributes = [.foregroundColor: AppColor.label]
        UINavigationBar.appearance().standardAppearance = appearanceN
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceN
        
        UIBarButtonItem.appearance().tintColor = AppColor.label
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .medium)], for: .normal)
        
        BaseView.appearance().backgroundColor = AppColor.backgroundColor
        
        UILabel.appearance().textColor = AppColor.label
        
        UITableView.appearance().bounces = false
        UITableView.appearance().backgroundColor = AppColor.backgroundColor
        UITableView.appearance().separatorColor = AppColor.label
        UITableViewCell.appearance().backgroundColor = AppColor.backgroundColor
        
        UICollectionView.appearance().bounces = false
        UICollectionView.appearance().backgroundColor = AppColor.backgroundColor
    }
    
}

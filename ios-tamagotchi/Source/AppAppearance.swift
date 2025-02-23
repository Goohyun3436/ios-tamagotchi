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
        let attributesN: [NSAttributedString.Key : Any] = [.foregroundColor: AppColor.label, .font: UIFont.systemFont(ofSize: 15, weight: .bold)]
        appearanceN.configureWithTransparentBackground()
        appearanceN.backgroundColor = AppColor.backgroundColor
        appearanceN.titleTextAttributes = attributesN
        appearanceN.largeTitleTextAttributes = attributesN
        UINavigationBar.appearance().standardAppearance = appearanceN
        UINavigationBar.appearance().compactAppearance = appearanceN
        UINavigationBar.appearance().scrollEdgeAppearance = appearanceN
        
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .medium)]
        UIBarButtonItem.appearance().tintColor = AppColor.label
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .selected)
        
        BaseView.appearance().backgroundColor = AppColor.backgroundColor
        
        UILabel.appearance().textColor = AppColor.label
        
        UITableView.appearance().bounces = false
        UITableView.appearance().backgroundColor = AppColor.backgroundColor
        UITableView.appearance().separatorColor = AppColor.label
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().backgroundColor = AppColor.backgroundColor
        
        UICollectionView.appearance().bounces = false
        UICollectionView.appearance().backgroundColor = AppColor.backgroundColor
    }
    
}

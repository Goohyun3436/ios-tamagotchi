//
//  SettingView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import SnapKit

final class SettingView: BaseView {
    
    //MARK: - UI Property
    let tableView = {
        let view = UITableView()
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        return view
    }()
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func setupAttributes() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 50
    }
    
}

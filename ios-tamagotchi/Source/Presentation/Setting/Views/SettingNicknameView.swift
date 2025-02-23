//
//  SettingNicknameView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/23/25.
//

import UIKit
import SnapKit

final class SettingNicknameView: BaseView {
    
    //MARK: - UI Property
    let textField = BorderTextField()
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(textField)
    }
    
    override func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
    }
    
    override func setupAttributes() {
        textField.textAlignment = .left
    }
    
}

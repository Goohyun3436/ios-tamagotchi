//
//  TGPickerView.swift
//  ios-tamagotchi
//
//  Created by Goo on 2/20/25.
//

import UIKit
import SnapKit

final class TGPickerView: BaseView {
    
    //MARK: - UI Property
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.register(TGCollectionViewCell.self, forCellWithReuseIdentifier: TGCollectionViewCell.id)
        return view
    }()
    
    //MARK: - Method
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 16
        let hSpacing: CGFloat = 14
        let vSpacing: CGFloat = 28
        let cellPerRow: CGFloat = 3
        let width: CGFloat = (UIScreen.main.bounds.width - inset * 2 - hSpacing * (cellPerRow - 1)) / cellPerRow
        let height: CGFloat = width * 0.85 + 28
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumInteritemSpacing = hSpacing
        layout.minimumLineSpacing = vSpacing
        
        return layout
    }
    
    //MARK: - Setup Method
    override func setupUI() {
        addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
}

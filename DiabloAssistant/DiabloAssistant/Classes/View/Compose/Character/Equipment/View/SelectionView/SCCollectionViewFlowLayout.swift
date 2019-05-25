//
//  SCCollectionViewFlowLayout.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 25/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else{
            return
        }
        collectionView.backgroundColor = .clear
        scrollDirection = UICollectionView.ScrollDirection.horizontal
        itemSize = CGSize(width: 64, height: 128)
        minimumLineSpacing = 20
        minimumInteritemSpacing = 0
    }
}

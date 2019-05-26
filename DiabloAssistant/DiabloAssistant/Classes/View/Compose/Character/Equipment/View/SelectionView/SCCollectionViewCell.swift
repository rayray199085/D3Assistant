//
//  SCCollectionViewCell.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 25/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCollectionViewCell: UICollectionViewCell {
    private lazy var itemButton = SCCollectionViewButton.viewButton()
    var item: SCEquipmentItem?{
        didSet{
            itemButton.item = item
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layer.drawsAsynchronously = true
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func didSelected(){
        itemButton.addPopAlphaAnimation(fromValue: 1.0, toValue: 0.3, duration: 0.2) { [weak self](_, _) in
            self?.itemButton.addPopAlphaAnimation(fromValue: 0.3, toValue: 1.0, duration: 0.2)
        }
    }
}
private extension SCCollectionViewCell{
    func setupUI(){
        contentView.addSubview(itemButton)
    }
}

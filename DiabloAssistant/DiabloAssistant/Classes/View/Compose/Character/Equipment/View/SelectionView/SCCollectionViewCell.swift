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
            itemButton.setIcon(image: item?.iconImage)
            itemButton.setTypeBackgroundImage(name: item?.details?.color)
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
}
private extension SCCollectionViewCell{
    func setupUI(){
        contentView.addSubview(itemButton)
    }
}

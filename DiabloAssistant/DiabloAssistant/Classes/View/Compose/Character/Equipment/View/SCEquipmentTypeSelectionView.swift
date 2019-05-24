//
//  SCEquipmentTypeSelectionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 24/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell_id"
class SCEquipmentTypeSelectionView: UIView {
    
    var itemNames: [String]?
    
    class func selectionView()->SCEquipmentTypeSelectionView{
        let nib = UINib(nibName: "SCEquipmentTypeSelectionView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCEquipmentTypeSelectionView
        v.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
        return v
    }
}


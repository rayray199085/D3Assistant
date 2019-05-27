//
//  SCEquipmentButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 27/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCEquipmentButton: UIButton {
    var dps: Double = 0
    var minArmor: Double = 0
    var maxArmor: Double = 0
    
    func resetButtonContent(){
        setImage(nil, for: [])
        setBackgroundImage(nil, for: [])
        dps = 0
        minArmor = 0
        maxArmor = 0
    }
    func setButtonContent(item: SCEquipmentItem?){
        setImage(item?.iconImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: [])
        setBackgroundImage(UIImage(named: "color_\(item?.details?.color ?? "")"), for: [])
        setTitle("", for: [])
        dps = item?.details?.dpsValue ?? 0
        minArmor = item?.details?.minArmor ?? 0
        maxArmor = item?.details?.maxArmor ?? 0
    }
}

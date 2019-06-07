//
//  SCProfileFollowerEquipButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 7/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollowerEquipButton: UIButton {
    var item: SCProfileEquipmentItem?{
        didSet{
            setImage(item?.iconImage?.withRenderingMode(
                .alwaysOriginal), for: [])
            setBackgroundImage(UIImage(named: "color_\(item?.displayColor ?? "")"), for: [])
        }
    }
}

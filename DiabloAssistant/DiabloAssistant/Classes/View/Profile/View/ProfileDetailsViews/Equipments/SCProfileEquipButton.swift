//
//  SCProfileEquipButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileEquipButton: UIButton {
    var item: SCProfileEquipmentItem?{
        didSet{
            guard let iconImage = item?.iconImage,
                  let bgColor = item?.displayColor else{
                return
            }
            imageView?.clipsToBounds = false
            imageView?.contentMode = .scaleAspectFill
            setImage(
                iconImage.withRenderingMode(
                    UIImage.RenderingMode.alwaysOriginal),
                    for: [])
            setBackgroundImage(UIImage(named: "color_\(bgColor)"), for: [])
        }
    }
}

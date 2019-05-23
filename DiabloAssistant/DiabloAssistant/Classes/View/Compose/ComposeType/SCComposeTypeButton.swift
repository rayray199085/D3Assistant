//
//  SCComposeTypeButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 17/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCComposeTypeButton: UIControl {
    var characterName: String?
    var characterEquipmentName: String?
    
    @IBOutlet weak var buttonImageView: UIImageView!
    @IBOutlet weak var buttonLabel: UILabel!
    class func composeTypeButton(imageName: String, labelText: String)-> SCComposeTypeButton{
        let nib = UINib(nibName: "SCComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! SCComposeTypeButton
        btn.buttonImageView.image = UIImage(named: imageName)
        btn.buttonImageView.setCircleImage()
        btn.buttonLabel.text = labelText
        btn.buttonLabel.textColor = SCButtonTitleColor
        return btn
    }
}

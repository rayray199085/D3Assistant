//
//  SCProfileHero.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHero: NSObject {
    @objc var id: String?
    @objc var classSlug: String?
    @objc var gender: Int = 0
    @objc var name: String?
    @objc var level: Int = 0
    @objc var paragonLevel: Int = 0
    @objc var basicInfoAttrText: NSAttributedString{
        let attrText = NSMutableAttributedString(string: "")
        let lvlText = NSMutableAttributedString(string: "\(level)")
        lvlText.setAttributes(
            [NSAttributedString.Key.font : UIFont(name: "Exocet", size: 20)!,
             NSAttributedString.Key.foregroundColor: SCButtonTitleColor], range:  NSRange(location: 0, length: lvlText.length))
        attrText.append(lvlText)
        // integer value to string with comma
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:paragonLevel))
        
        let paragonLvlText = NSMutableAttributedString(string: " (\(formattedNumber ?? "")) ")
        paragonLvlText.setAttributes(
            [NSAttributedString.Key.font : UIFont(name: "Exocet", size: 20)!,
             NSAttributedString.Key.foregroundColor: SCProfileParagonLevelColor], range:  NSRange(location: 0, length: paragonLvlText.length))
        attrText.append(paragonLvlText)
        
        let clsText = NSMutableAttributedString(string: classSlug ?? "")
        clsText.setAttributes(
            [NSAttributedString.Key.font : UIFont(name: "Exocet", size: 20)!,
             NSAttributedString.Key.foregroundColor: SCButtonTitleColor], range:  NSRange(location: 0, length: clsText.length))
        attrText.append(clsText)

        return attrText
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}

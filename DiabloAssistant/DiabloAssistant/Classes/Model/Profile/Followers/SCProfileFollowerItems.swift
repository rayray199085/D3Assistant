//
//  SCProfileFollowerItems.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollowerItems: NSObject {
    @objc var neck: SCProfileEquipmentItem?
    @objc var leftFinger: SCProfileEquipmentItem?
    @objc var rightFinger: SCProfileEquipmentItem?
    @objc var mainHand: SCProfileEquipmentItem?
    @objc var offHand: SCProfileEquipmentItem?
    
    override var description: String{
        return yy_modelDescription()
    }
}

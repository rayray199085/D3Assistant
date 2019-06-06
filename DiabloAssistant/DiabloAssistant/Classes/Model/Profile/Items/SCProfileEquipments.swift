//
//  SCProfileEquipments.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileEquipments: NSObject {
    
    @objc var head: SCProfileEquipmentItem?
    @objc var neck: SCProfileEquipmentItem?
    @objc var torso: SCProfileEquipmentItem?
    @objc var shoulders: SCProfileEquipmentItem?
    @objc var legs: SCProfileEquipmentItem?
    @objc var waist: SCProfileEquipmentItem?
    @objc var hands: SCProfileEquipmentItem?
    @objc var bracers: SCProfileEquipmentItem?
    @objc var feet: SCProfileEquipmentItem?
    @objc var leftFinger: SCProfileEquipmentItem?
    @objc var rightFinger: SCProfileEquipmentItem?
    @objc var mainHand: SCProfileEquipmentItem?
    @objc var offHand: SCProfileEquipmentItem?
    @objc var special: SCProfileEquipmentItem?
    var items: [SCProfileEquipmentItem?]?{
        return [head,shoulders,neck,torso,hands,bracers,waist,leftFinger,rightFinger,legs,mainHand,offHand,feet,special]
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}

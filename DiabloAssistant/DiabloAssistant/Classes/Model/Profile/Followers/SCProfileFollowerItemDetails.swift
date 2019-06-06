//
//  SCProfileFollowerItemDetails.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 6/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollowerItemDetails: NSObject {
    @objc var templar: SCProfileEquipments?
    @objc var scoundrel: SCProfileEquipments?
    @objc var enchantress: SCProfileEquipments?
    
    override var description: String{
        return yy_modelDescription()
    }
}

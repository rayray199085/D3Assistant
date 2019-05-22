//
//  SCEquipmentType.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 22/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCEquipmentType: NSObject {
    @objc var id: String?
    @objc var name: String?
    @objc var path: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}

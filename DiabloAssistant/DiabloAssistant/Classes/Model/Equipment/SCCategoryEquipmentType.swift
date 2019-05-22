//
//  SCCategoryEquipmentType.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 22/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCategoryEquipmentType: NSObject {
    @objc var type: String?
    @objc var group: [SCEquipmentType]
    
    override init() {
        group = [SCEquipmentType]()
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}

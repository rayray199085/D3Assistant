//
//  SCEquipmentItems.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 24/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCItemCommonTypes: NSObject{
    @objc var itemType: String
    @objc var items: SCCategoryEquipmentType?
    init(typeName: String){
        itemType = typeName
    }
    override var description: String{
        return yy_modelDescription()
    }
}

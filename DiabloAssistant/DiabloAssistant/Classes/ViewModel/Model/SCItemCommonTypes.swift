//
//  SCEquipmentItems.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 24/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCItemCommonTypes: CustomStringConvertible{
    var description: String{
        return items?.description ?? ""
    }
    var itemType: String
    var items: SCCategoryEquipmentType?
    init(typeName: String){
        itemType = typeName
    }
}

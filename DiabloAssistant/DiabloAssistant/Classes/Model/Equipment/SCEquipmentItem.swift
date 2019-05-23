//
//  SCItemType.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 23/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCEquipmentItem: NSObject {
    @objc var id: String?
    @objc var slug: String?
    @objc var name: String?
    @objc var icon: String?
    @objc var path: String?
    @objc var iconImage: UIImage?
    
    override var description: String{
        return yy_modelDescription()
    }
}

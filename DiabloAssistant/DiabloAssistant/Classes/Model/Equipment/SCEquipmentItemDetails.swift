//
//  SCEquipmentItemDetails.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 23/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCEquipmentItemDetails: NSObject {

    @objc var id: String?
    @objc var slug: String?
    @objc var name: String?
    @objc var icon: String?
    @objc var iconImage: UIImage?
    @objc var requiredLevel: Int = 0
    @objc var flavorTextHtml: String?
    @objc var type: SCDetailsType?
    @objc var dps: String?
    @objc var damageHtml: String?
    @objc var armorHtml: String?
    @objc var attributes: SCDetailsAttributes?
    @objc var randomAffixes: [SCDetailsRandomAffixes]?
    @objc var color: String?
    @objc var setNameHtml: String?
    @objc var setDescriptionHtml: String?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["randomAffixes": SCDetailsRandomAffixes.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

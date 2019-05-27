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
    @objc var typeName: String?
    @objc var icon: String?
    @objc var requiredLevel: Int = 1
    @objc var flavorTextHtml: String?
    @objc var type: SCDetailsType?
    @objc var dps: String?{
        didSet{
            guard var dpsString = dps else{
                    return
            }
            dpsString.removeAll { (character) -> Bool in
                character == ","
            }
            let value = Double(dpsString) ?? 0
            dpsValue = value
        }
    }
    @objc var dpsValue: Double = 0
    @objc var damageHtml: String?
    @objc var armorHtml: String?{
        didSet{
            guard var armor = armorHtml else{
                return
            }
            armor.removeAll { (character) -> Bool in
                return character == ","
            }
            var digits = ""
            for c in armor{
                if c == "-"{
                    continue
                }
                else if c == " "{
                    guard let value = Double(digits) else{
                        continue
                    }
                    minArmor = minArmor == 0 ? value : minArmor
                    digits.removeAll()
                }else{
                    digits += "\(c)"
                }
            }
            if digits.count > 0{
                maxArmor = Double(digits)!
            }
        }
    }
    @objc var minArmor: Double = 0
    @objc var maxArmor: Double = 0
    @objc var attributes: SCDetailsAttributes?
    @objc var randomAffixes: [SCDetailsRandomAffixes]?
    @objc var color: String?
    @objc var setNameHtml: String?
    @objc var setDescriptionHtml: String?
    @objc var accountBound: Int = 0
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["randomAffixes": SCDetailsRandomAffixes.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

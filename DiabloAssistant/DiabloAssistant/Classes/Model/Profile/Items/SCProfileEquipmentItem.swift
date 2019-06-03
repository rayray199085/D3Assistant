//
//  SCProfileEquipmentItem.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileEquipmentItem: NSObject {
    @objc var id: String?
    @objc var name: String?
    @objc var icon: String?
    @objc var displayColor: String?
    @objc var iconImage: UIImage?
    @objc var requiredLevel: Int = 1
    @objc var itemLevel: Int = 1
    @objc var accountBound: Int = 0
    @objc var typeName: String?
    @objc var type: SCDetailsType?
    @objc var armor: Double = 0{
        didSet{
            armor = Double(round(1000 * armor) / 1000)
        }
    }
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
    @objc var attacksPerSecond: Double = 0{
        didSet{
            attacksPerSecond = Double(round(1000 * attacksPerSecond) / 1000)
        }
    }
    @objc var minDamage: Int = 0
    @objc var maxDamage: Int = 0
    @objc var attributes: SCDetailsAttributes?
    @objc var openSockets: Int = 0
    @objc var gems: [SCProfileGem]?
    @objc var set: SCProfileSet?
    @objc var augmentation: String?
    @objc var stackSizeMax: Int = 0
    @objc var elementalType: String?
    @objc var damage: String?
    @objc var slots: String?
    @objc var transmog: SCProfileTransmog?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["gems": SCProfileGem.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

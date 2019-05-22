//
//  SCSkill.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCSkill: NSObject {
    @objc var active: [SCActiveSkill]?
    @objc var passive: [SCPassiveSkill]?
    
    override var description: String{
        return yy_modelDescription()
    }
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["active": SCActiveSkill.self, "passive": SCPassiveSkill.self]
    }
}

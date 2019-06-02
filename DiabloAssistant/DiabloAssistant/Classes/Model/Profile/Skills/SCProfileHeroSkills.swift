//
//  SCProfileHeroSkills.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHeroSkills: NSObject {
    @objc var active: [SCProfileHeroActive]?
    @objc var passive: [SCProfileHeroPassive]?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["active": SCProfileHeroActive.self,
                "passive": SCProfileHeroPassive.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

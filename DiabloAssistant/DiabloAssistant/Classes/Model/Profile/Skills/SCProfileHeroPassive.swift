//
//  SCProfileHeroPassive.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHeroPassive: NSObject {
    @objc var skill: SCProfileSkillItem?
    
    override var description: String{
        return yy_modelDescription()
    }
}

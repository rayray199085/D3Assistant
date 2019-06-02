//
//  SCProfileHeroActiveSkill.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHeroActive: NSObject {
    @objc var skill: SCProfileSkillItem?
    @objc var rune: SCProfileHeroActiveRune?
    
    override var description: String{
        return yy_modelDescription()
    }
}

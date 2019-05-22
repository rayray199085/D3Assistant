//
//  SCCharacter.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCharacter: NSObject {
    @objc var slug: String?
    @objc var name: String?
    @objc var skillCategories: [SCSkillCategory]?
    @objc var skills: SCSkill?
    
    override var description: String{
        return yy_modelDescription()
    }
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["skillCategories": SCSkillCategory.self]
    }
}

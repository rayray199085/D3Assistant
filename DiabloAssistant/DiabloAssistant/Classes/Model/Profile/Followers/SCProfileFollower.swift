//
//  SCProfileFollower.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollower: NSObject {
    @objc var slug: String?
    @objc var level: Int = 0
    @objc var items: SCProfileFollowerItems?
    @objc var stats: SCProfileFollowerStats?
    @objc var skills: [SCProfileSkillItem]?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["skills": SCProfileSkillItem.self]
    }
    
    override var description: String{
        return yy_modelDescription()
    }
}

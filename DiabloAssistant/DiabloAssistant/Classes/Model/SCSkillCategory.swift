//
//  SCSkillCategory.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCSkillCategory: NSObject {
    @objc var name: String?
    @objc var slug: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}

//
//  SCProfileSkillItem.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileSkillItem: NSObject {
    @objc var descriptionHtml: String?
    @objc var icon: String?
    @objc var level: Int = 0
    @objc var name: String?
    @objc var slug: String?
    @objc var skillImage: UIImage?
    
    override var description: String{
        return yy_modelDescription()
    }
}

//
//  SCFollowerSkill.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCFollowerSkill: NSObject {
    
    @objc var slug: String?
    @objc var name: String?
    @objc var icon: String?
    @objc var level: Int = 0
    @objc var descriptionHtml: String?
    @objc var iconImage: UIImage?
    
    override var description: String{
        return yy_modelDescription()
    }
}

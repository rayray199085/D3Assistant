//
//  SCFollowerInfo.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCFollowerInfo: NSObject {
    
    @objc var slug: String?
    @objc var name: String?
    @objc var realName: String?
    @objc var portrait: String?
    @objc var skills: [SCFollowerSkill]?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["skills": SCFollowerSkill.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

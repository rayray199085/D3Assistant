//
//  SCProfileData.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileData: NSObject {
    @objc var battleTag: String?
    @objc var region: String?
    @objc var heroes: [SCProfileHero]?
    @objc var lastUpdated: TimeInterval = 0{
        didSet{
            recentUpdatedTime = Date.timeInterval2String(timeInterval: lastUpdated)
        }
    }
    @objc var recentUpdatedTime: String?
    
    @objc var kills: SCProfilesKills?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["heroes": SCProfileHero.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

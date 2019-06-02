//
//  SCProfileFollowerList.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollowerList: NSObject {
    @objc var templar: SCProfileFollower?
    @objc var scoundrel: SCProfileFollower?
    @objc var enchantress: SCProfileFollower?
    
    override var description: String{
        return yy_modelDescription()
    }
}

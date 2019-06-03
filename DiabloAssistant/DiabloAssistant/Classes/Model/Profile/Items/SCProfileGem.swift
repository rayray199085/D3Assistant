//
//  SCProfileGem.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 3/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileGem: NSObject {
    @objc var item: SCProfileGemItem?
    @objc var attributes: [String]?
    @objc var isGem: Int = 0
    @objc var isJewel: Int = 0
    @objc var jewelRank: Int = 0
    @objc var jewelSecondaryUnlockRank: Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}

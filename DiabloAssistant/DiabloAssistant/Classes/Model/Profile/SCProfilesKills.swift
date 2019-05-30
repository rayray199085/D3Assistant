//
//  SCProfilesKills.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfilesKills: NSObject {
    @objc var monsters: Int = 0
    @objc var elites: Int = 0
    @objc var hardcoreMonsters: Int = 0
    override var description: String{
        return yy_modelDescription()
    }
}

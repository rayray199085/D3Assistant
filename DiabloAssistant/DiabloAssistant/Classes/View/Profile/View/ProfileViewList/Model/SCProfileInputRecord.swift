//
//  SCProfileInputRecord.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 5/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileInputRecord: NSObject {
    @objc var battleTag: String?
    @objc var region: String?
    @objc var loginCount: Int = 0
    
    func setInfo(battleTag: String, region: String){
        self.battleTag = battleTag
        self.region = region
        loginCount += 1
    }
}

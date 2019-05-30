//
//  SCProfileHero.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHero: NSObject {
    @objc var id: String?
    @objc var classSlug: String?
    @objc var gender: Int = 0
    @objc var name: String?
    @objc var level: Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}

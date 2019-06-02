//
//  SCProfileHeroActiveRune.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHeroActiveRune: NSObject {
    @objc var descriptionHtml: String?
    @objc var type: String?
    @objc var level: Int = 0
    @objc var name: String?
    @objc var slug: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}

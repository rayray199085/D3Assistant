//
//  SCRunes.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCRunes: NSObject {
    @objc var slug: String?
    @objc var type: String?
    @objc var name: String?
    @objc var level: Int = 0
    @objc var descriptionHtml: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}

//
//  SCProfileAttributes.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileAttributes: NSObject {
    @objc var primary: [String]?
    @objc var secondary: [String]?
    @objc var other: [String]?
    
    override var description: String{
        return yy_modelDescription()
    }
}

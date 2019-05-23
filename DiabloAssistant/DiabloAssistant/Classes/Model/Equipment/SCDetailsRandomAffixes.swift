//
//  SCDetailsRandomAffixes.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 23/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCDetailsRandomAffixes: NSObject {
    @objc var oneOf: [SCMainAttribute]?
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["oneOf": SCMainAttribute.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

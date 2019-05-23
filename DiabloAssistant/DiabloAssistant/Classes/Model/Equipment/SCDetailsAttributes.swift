//
//  SCDetailsAttributes.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 23/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCDetailsAttributes: NSObject {
    @objc var other: [SCMainAttribute]?
    @objc var primary: [SCMainAttribute]?
    @objc var secondary: [SCMainAttribute]?
    
    
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["other": SCMainAttribute.self,
                "primary": SCMainAttribute.self,
                "secondary": SCMainAttribute.self]
    }
    override var description: String{
        return yy_modelDescription()
    }
}

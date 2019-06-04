//
//  SCProfileGemItem.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 3/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileGemItem: NSObject {
    @objc var id: String?
    @objc var slug: String?
    @objc var name: String?
    @objc var icon: String?
    @objc var iconImage: UIImage?
    @objc var path: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}

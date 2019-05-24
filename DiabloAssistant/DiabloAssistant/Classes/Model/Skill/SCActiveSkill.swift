//
//  SCActiveSkill.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCActiveSkill: NSObject {
    @objc var descriptionHtml: String?
    @objc var icon: String?
    @objc var level: Int = 0
    @objc var name: String?
    @objc var slug: String?
    @objc var skillImage: UIImage?
    @objc var runes: [SCRunes]?
    @objc var type: String?
    override var description: String{
        return yy_modelDescription()
    }
}

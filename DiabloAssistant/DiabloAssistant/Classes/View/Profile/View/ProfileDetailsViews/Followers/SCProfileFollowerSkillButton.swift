//
//  SCProfileFollowerSkillButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 7/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollowerSkillButton: UIButton {
    var skill: SCProfileSkillItem?{
        didSet{
            setBackgroundImage(skill?.skillImage, for: [])
        }
    }
    func clearPreviousContent(){
        skill = nil
    }
}

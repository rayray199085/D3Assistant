//
//  HelperCommon.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 15/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

let SCClientId: String = "f3dead0583644ad095480c4ef2efcf67"
let SCClientSecret: String = "Xmyg5EQaUwyQ9RMpj1PcPAoZDj7ZQPw0"
let SCRedirectURL: String = "https://baidu.com"

let SCAttributedColor : UIColor = UIColor(displayP3Red: 18.0 / 255, green: 34.0 / 255, blue: 36.0 / 255, alpha: 1.0)
let SCButtonTitleColor: UIColor = UIColor(displayP3Red: 240.0 / 255, green: 203.0 / 255, blue: 111.0 / 255, alpha: 1.0)
let SCNaviBarBgColor: UIColor = UIColor(displayP3Red: 18.0 / 255, green: 18.0 / 255, blue: 18.0 / 255, alpha: 1.0)

/**
 barbarian 4 5 4 4 3 3
 crusader  4 5 4 4 3 4
 demon-hunter 5 4 3 4 4 4
 monk 4 3 4 3 4 4
 necromancer 3 3 4 4 3 4
 witch-doctor 4 4 4 3 5 3
 wizard 4 4 4 5 5 4
 */
let SCActiveSkillsDictionaryArray = [
    ["name":"barbarian","activeSkills":[4,5,4,4,3,3]],
    ["name":"crusader","activeSkills":[4,5,4,4,3,4]],
    ["name":"demon-hunter","activeSkills":[5,4,3,4,4,4]],
    ["name":"monk","activeSkills":[4,3,4,3,4,4]],
    ["name":"necromancer","activeSkills":[3,3,4,4,3,4]],
    ["name":"witch-doctor","activeSkills":[4,4,4,3,5,3]],
    ["name":"wizard","activeSkills":[4,4,4,5,5,4]]]

let SCUserShouldLoginNotification = "SCUserShouldLoginNotification"
let SCUserSuccessLoginNotification = "SCUserSuccessLoginNotification"



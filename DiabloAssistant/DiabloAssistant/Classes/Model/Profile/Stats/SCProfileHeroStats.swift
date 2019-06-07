//
//  SCProfileHeroStats.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileHeroStats: NSObject {
    @objc var life: Double = 0{
        didSet{
            life = Double(round(1000 * life) / 1000)
        }
    }
    @objc var damage: Int = 0
    @objc var toughness: Int = 0
    @objc var healing: Double = 0
    @objc var attackSpeed: Double = 0{
        didSet{
            attackSpeed = Double(round(1000 * attackSpeed) / 1000)
        }
    }
    @objc var armor: Int = 0
    @objc var strength: Double = 0{
        didSet{
            strength = Double(round(1000 * strength) / 1000)
        }
    }
    @objc var dexterity: Int = 0
    @objc var vitality: Int = 0
    @objc var intelligence: Int = 0
    @objc var physicalResist: Int = 0
    @objc var fireResist: Int = 0
    @objc var coldResist: Int = 0
    @objc var lightningResist: Int = 0
    @objc var poisonResist: Int = 0
    @objc var arcaneResist: Int = 0
    @objc var blockChance: Double = 0{
        didSet{
            blockChance = Double(round(1000 * blockChance) / 1000)
        }
    }
    @objc var blockAmountMin: Int = 0
    @objc var blockAmountMax: Int = 0
    @objc var goldFind: Double = 0{
        didSet{
            goldFind = Double(round(1000 * goldFind) / 1000)
        }
    }
    @objc var critChance: Double = 0{
        didSet{
            critChance = Double(round(1000 * critChance) / 1000)
        }
    }
    @objc var thorns: Int = 0
    @objc var lifeSteal: Int = 0
    @objc var lifePerKill: Int = 0
    @objc var lifeOnHit: Int = 0
    @objc var primaryResource: Int = 0
    @objc var secondaryResource: Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}

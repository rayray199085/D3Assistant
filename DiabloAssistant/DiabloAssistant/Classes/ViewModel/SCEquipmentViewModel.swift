//
//  SCEquipmentViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 22/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCEquipmentViewModel: NSObject{
   
    var characterName: String?
    var equipmentTypes: [SCEquipmentType]?
    var categoryEquipmentTypes: [SCCategoryEquipmentType]?
    
    @objc lazy var weapons = [SCItemCommonTypes]()
    @objc lazy var heads = [SCItemCommonTypes]()
    @objc lazy var shoulders = [SCItemCommonTypes]()
    @objc lazy var torsos = [SCItemCommonTypes]()
    @objc lazy var wrists = [SCItemCommonTypes]()
    @objc lazy var hands = [SCItemCommonTypes]()
    @objc lazy var waists = [SCItemCommonTypes]()
    @objc lazy var legs = [SCItemCommonTypes]()
    @objc lazy var feet = [SCItemCommonTypes]()
    @objc lazy var amulets = [SCItemCommonTypes]()
    @objc lazy var rings = [SCItemCommonTypes]()
    @objc lazy var offHands = [SCItemCommonTypes]()
    @objc lazy var followerSpecials = [SCItemCommonTypes]()
    @objc lazy var others = [SCItemCommonTypes]()
    lazy var temporyStoredItems = [SCCategoryEquipmentType:[SCEquipmentItem]]()
   
    init(characterName: String?) {
        self.characterName = characterName
    }
    
    func loadEquipmentTypeList(completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getEquipmentTypeList { [weak self] (array, isSuccess) in
            guard let array = array,
                var types = NSArray.yy_modelArray(with: SCEquipmentType.self, json: array) as? [SCEquipmentType] else{
                completion(isSuccess)
                return
            }
            types.sort(by: { (type0, type1) -> Bool in
                return type0.name! < type1.name!
            })
            self?.categoryEquipmentTypes = [SCCategoryEquipmentType]()
            for type in types{
                let res = self?.categoryEquipmentTypes?.filter({ (ct) -> Bool in
                    return ct.type == type.name
                })
                if res?.count ?? 0 > 0{
                    res?[0].group.append(type)
                }else{
                    let newCt = SCCategoryEquipmentType()
                    newCt.type = type.name
                    newCt.group.append(type)
                    self?.categoryEquipmentTypes?.append(newCt)
                }
            }
           
            for categoryType in self?.categoryEquipmentTypes ?? []{
                switch categoryType.type{
                case "Axe","Dagger","Mace","Spear","Sword","Ceremonial Knife","Fist Weapon",
                     "Flail","Mighty Weapon","Scythe","Two-Handed Axe","Two-Handed Mace","Polearm","Staff","Two-Handed Sword","Daibo","Two-Handed Flail","Two-Handed Mighty Weapon","Two-Handed Scythe","Bow","Crossbow","Hand Crossbow","Wand","Weapon":
                   
                    let weapon = SCItemCommonTypes(typeName: categoryType.type!)
                    weapon.items = categoryType
                    self?.weapons.append(weapon)
                    
                case "Helm", "Spirit Stone", "Voodoo Mask", "Wizard Hat":
                    let head = SCItemCommonTypes(typeName: categoryType.type!)
                    head.items = categoryType
                    self?.heads.append(head)
                    
                case "Shoulders":
                    let shoulder = SCItemCommonTypes(typeName: categoryType.type!)
                    shoulder.items = categoryType
                    self?.shoulders.append(shoulder)
                case "Chest Armor", "Cloak":
                    let torso = SCItemCommonTypes(typeName: categoryType.type!)
                    torso.items = categoryType
                    self?.torsos.append(torso)
                case "Bracers":
                    let wrist = SCItemCommonTypes(typeName: categoryType.type!)
                    wrist.items = categoryType
                    self?.wrists.append(wrist)
                case "Gloves":
                    let hand = SCItemCommonTypes(typeName: categoryType.type!)
                    hand.items = categoryType
                    self?.hands.append(hand)
                case "Belt", "Mighty Belt":
                    let waist = SCItemCommonTypes(typeName: categoryType.type!)
                    waist.items = categoryType
                    self?.waists.append(waist)
                case "Pants":
                    let leg = SCItemCommonTypes(typeName: categoryType.type!)
                    leg.items = categoryType
                    self?.legs.append(leg)
                case "Boots":
                    let foot = SCItemCommonTypes(typeName: categoryType.type!)
                    foot.items = categoryType
                    self?.feet.append(foot)
                case "Amulet":
                    let amulet = SCItemCommonTypes(typeName: categoryType.type!)
                     amulet.items = categoryType
                    self?.amulets.append(amulet)
                case "Ring":
                    let ring = SCItemCommonTypes(typeName: categoryType.type!)
                     ring.items = categoryType
                    self?.rings.append(ring)
                case "Shield","Crusader Shield","Source", "Mojo", "Quiver", "Phylactery":
                    let offHand = SCItemCommonTypes(typeName: categoryType.type!)
                    offHand.items = categoryType
                    self?.offHands.append(offHand)
                case "Enchantress Focus", "Scoundrel Token", "Templar Relic":
                    let special = SCItemCommonTypes(typeName: categoryType.type!)
                    special.items = categoryType
                    self?.followerSpecials.append(special)
                case "Consumable","Potion","Crafting Material", "Blacksmith Plan", "Jeweler Design", "Tome of Training","Dye","Gem","Portal Device","Gold","Quest","Shard", "Greater Shard","Scroll","Transmogrify Plan":
                    let other = SCItemCommonTypes(typeName: categoryType.type!)
                    other.items = categoryType
                    self?.others.append(other)
                default:
                    break
                }
            }
            completion(isSuccess)
        }
    }
    
    func loadEquipmentType(typeIndexGroup: SCCategoryEquipmentType?, completion:@escaping (_ items: [SCEquipmentItem]?,_ isSuccess: Bool)->()){
        let group = DispatchGroup()
        var itemGroup = [SCEquipmentItem]()
        for item in typeIndexGroup?.group ?? []{
            guard let type = item.id else{
                continue
            }
            group.enter()
            SCNetworkManager.shared.getEquipmentType(type: type) { (array, isSuccess) in
                guard let array = array,
                      let itemTypes = NSArray.yy_modelArray(with: SCEquipmentItem.self, json: array) as? [SCEquipmentItem] else{
                    completion(nil, isSuccess)
                    group.leave()
                    return
                }
                for item in itemTypes{
                    guard let icon = item.icon else{
                        continue
                    }
                    group.enter()
                    SCNetworkManager.shared.getItemImage(icon: icon,size: SCItemImageSize.large, completion: { (image) in
                        item.iconImage = image
                        group.leave()
                    })
                    
                    group.enter()
                    self.loadEquipmentItemDetails(item: item) { (details, isSuccess) in
                        item.details = details
                        group.leave()
                    }
                }
                itemGroup += itemTypes
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            itemGroup.sort(by: { (item0, item1) -> Bool in
                return item0.details?.requiredLevel ?? 0 < item1.details?.requiredLevel ?? 0
            })
            self.temporyStoredItems[typeIndexGroup!] = itemGroup
            completion(itemGroup, true)
        }
    }
    
    private func loadEquipmentItemDetails(item: SCEquipmentItem?, completion:@escaping (_ details: SCEquipmentItemDetails?, _ isSuccess: Bool)->()){
        guard let item = item else{
            completion(nil, false)
            return
        }
        SCNetworkManager.shared.getItemDetails(item: item) { (dict, isSuccess) in
            guard let dict = dict,
                  let details = SCEquipmentItemDetails.yy_model(with: dict) else{
                completion(nil, isSuccess)
                return
            }
            completion(details, isSuccess)
        }
    }
}

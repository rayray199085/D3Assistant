//
//  SCEquipmentViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 22/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCEquipmentViewModel{
   
    var characterName: String?
    var equipmentTypes: [SCEquipmentType]?
    var categoryEquipmentTypes: [SCCategoryEquipmentType]?
    
    lazy var weapons = [SCWeapons]()
    lazy var heads = [SCHeads]()
    lazy var shoulders = [SCShoulders]()
    lazy var torsos = [SCTorsos]()
    lazy var wrists = [SCWrists]()
    lazy var hands = [SCHands]()
    lazy var waists = [SCWaists]()
    lazy var legs = [SCLegs]()
    lazy var feet = [SCFeet]()
    lazy var amulets = [SCAmulets]()
    lazy var rings = [SCRings]()
    lazy var offHands = [SCOffHands]()
    lazy var followerSpecials = [SCFollowerSpecial]()
    lazy var others = [SCOthers]()
   
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
                   
                    let weapon = SCWeapons(typeName: categoryType.type!)
                    weapon.items = categoryType
                    self?.weapons.append(weapon)
                    
                case "Helm", "Spirit Stone", "Voodoo Mask", "Wizard Hat":
                    let head = SCHeads(typeName: categoryType.type!)
                    head.items = categoryType
                    self?.heads.append(head)
                    
                case "Shoulders":
                    let shoulder = SCShoulders(typeName: categoryType.type!)
                    shoulder.items = categoryType
                    self?.shoulders.append(shoulder)
                case "Chest Armor", "Cloak":
                    let torso = SCTorsos(typeName: categoryType.type!)
                    torso.items = categoryType
                    self?.torsos.append(torso)
                case "Bracers":
                    let wrist = SCWrists(typeName: categoryType.type!)
                    wrist.items = categoryType
                    self?.wrists.append(wrist)
                case "Gloves":
                    let hand = SCHands(typeName: categoryType.type!)
                    hand.items = categoryType
                    self?.hands.append(hand)
                case "Belt", "Mighty Belt":
                    let waist = SCWaists(typeName: categoryType.type!)
                    waist.items = categoryType
                    self?.waists.append(waist)
                case "Pants":
                    let leg = SCLegs(typeName: categoryType.type!)
                    leg.items = categoryType
                    self?.legs.append(leg)
                case "Boots":
                    let foot = SCFeet(typeName: categoryType.type!)
                    foot.items = categoryType
                    self?.feet.append(foot)
                case "Amulet":
                    let amulet = SCAmulets(typeName: categoryType.type!)
                     amulet.items = categoryType
                    self?.amulets.append(amulet)
                case "Ring":
                    let ring = SCRings(typeName: categoryType.type!)
                     ring.items = categoryType
                    self?.rings.append(ring)
                case "Shield","Crusader Shield","Source", "Mojo", "Quiver", "Phylactery":
                    let offHand = SCOffHands(typeName: categoryType.type!)
                    offHand.items = categoryType
                    self?.offHands.append(offHand)
                case "Enchantress Focus", "Scoundrel Token", "Templar Relic":
                    let special = SCFollowerSpecial(typeName: categoryType.type!)
                    special.items = categoryType
                    self?.followerSpecials.append(special)
                case "Consumable","Potion","Crafting Material", "Blacksmith Plan", "Jeweler Design", "Tome of Training","Dye","Gem","Portal Device","Gold","Quest","Shard", "Greater Shard","Scroll","Transmogrify Plan":
                   
                    let other = SCOthers(typeName: categoryType.type!)
                    other.items = categoryType
                    self?.others.append(other)
                default:
                    break
                }
            }
            completion(isSuccess)
        }
    }
    
    func loadEquipmentType(typeIndexGroup: [SCCategoryEquipmentType]?, completion:@escaping (_ items: [[SCEquipmentItem]]?,_ isSuccess: Bool)->()){
        let group = DispatchGroup()
        var itemGroup = [[SCEquipmentItem]]()
        for type in typeIndexGroup ?? []{
            for item in type.group{
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
                        SCNetworkManager.shared.getItemImage(icon: icon,size: SCItemImageSize.small, completion: { (image) in
                            item.iconImage = image
                            group.leave()
                        })
                    }
                    itemGroup.append(itemTypes)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(itemGroup, true)
        }
    }
    
    func loadEquipmentItemDetails(item: SCEquipmentItem?, completion:@escaping (_ details: SCEquipmentItemDetails?, _ isSuccess: Bool)->()){
        guard let item = item else{
            completion(nil, false)
            return
        }
        SCNetworkManager.shared.getItemDetails(item: item) { (dict, isSuccess) in
            guard let dict = dict,
                  let details = SCEquipmentItemDetails.yy_model(with: dict),
                  let icon = details.icon else{
                completion(nil, isSuccess)
                return
            }
            SCNetworkManager.shared.getItemImage(icon: icon,size: SCItemImageSize.large, completion: { (image) in
                details.iconImage = image
                completion(details, isSuccess)
            })
            
        }
    }
}

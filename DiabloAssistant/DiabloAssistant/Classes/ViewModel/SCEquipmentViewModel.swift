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
    // one-handed
    lazy var axeTypes = [SCCategoryEquipmentType]()
    lazy var daggerTypes = [SCCategoryEquipmentType]()
    lazy var maceTypes = [SCCategoryEquipmentType]()
    lazy var spearTypes = [SCCategoryEquipmentType]()
    lazy var swordTypes = [SCCategoryEquipmentType]()
    lazy var ceremonialKnifeTypes = [SCCategoryEquipmentType]()
    lazy var FistTypes = [SCCategoryEquipmentType]()
    lazy var FlailTypes = [SCCategoryEquipmentType]()
    lazy var mightyTypes = [SCCategoryEquipmentType]()
    lazy var scytheTypes = [SCCategoryEquipmentType]()
    
    // two-handed
    lazy var twoHandedAxeTypes = [SCCategoryEquipmentType]()
    lazy var twoHandedMaceTypes = [SCCategoryEquipmentType]()
    lazy var polearmTypes = [SCCategoryEquipmentType]()
    lazy var staffTypes = [SCCategoryEquipmentType]()
    lazy var twoHandedSwordTypes = [SCCategoryEquipmentType]()
    lazy var daiboTypes = [SCCategoryEquipmentType]()
    lazy var twoHandedFlailTypes = [SCCategoryEquipmentType]()
    lazy var twoHandedMightyTypes = [SCCategoryEquipmentType]()
    lazy var twoHandedScytheTypes = [SCCategoryEquipmentType]()
    // ranged
    lazy var bowTypes = [SCCategoryEquipmentType]()
    lazy var crossbowTypes = [SCCategoryEquipmentType]()
    lazy var handedCrossbowTypes = [SCCategoryEquipmentType]()
    lazy var wandTypes = [SCCategoryEquipmentType]()
    
    lazy var otherWeapon = [SCCategoryEquipmentType]()
    
    lazy var headTypes = [SCCategoryEquipmentType]()
    lazy var shoulderTypes = [SCCategoryEquipmentType]()
    lazy var torsoTypes = [SCCategoryEquipmentType]()
    lazy var wristTypes = [SCCategoryEquipmentType]()
    lazy var handTypes = [SCCategoryEquipmentType]()
    lazy var waistTypes = [SCCategoryEquipmentType]()
    lazy var legTypes = [SCCategoryEquipmentType]()
    lazy var feetTypes = [SCCategoryEquipmentType]()
    lazy var jewelryTypes = [SCCategoryEquipmentType]()
    lazy var offHandTypes = [SCCategoryEquipmentType]()
    lazy var followerTypes = [SCCategoryEquipmentType]()
    lazy var consumableTypes = [SCCategoryEquipmentType]()
    lazy var craftingTypes = [SCCategoryEquipmentType]()
    lazy var dyeTypes = [SCCategoryEquipmentType]()
    lazy var gemTypes = [SCCategoryEquipmentType]()
    lazy var miscellaneousTypes = [SCCategoryEquipmentType]()
    lazy var goldTypes = [SCCategoryEquipmentType]()
    lazy var questTypes = [SCCategoryEquipmentType]()
    lazy var shardTypes = [SCCategoryEquipmentType]()
    lazy var scrollTypes = [SCCategoryEquipmentType]()
    lazy var planTypes = [SCCategoryEquipmentType]()
        
    
    init(characterName: String?) {
        self.characterName = characterName
    }
    
    func loadEquipmentTypeList(completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getEquipmentTypeList { [weak self] (array, isSuccess) in
            guard let array = array,
                let types = NSArray.yy_modelArray(with: SCEquipmentType.self, json: array) as? [SCEquipmentType] else{
                completion(isSuccess)
                return
            }
            
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
                case "Axe":
                    self?.axeTypes.append(categoryType)
                case "Dagger":
                    self?.daggerTypes.append(categoryType)
                case "Mace":
                    self?.maceTypes.append(categoryType)
                case "Spear":
                    self?.spearTypes.append(categoryType)
                case "Sword":
                    self?.swordTypes.append(categoryType)
                case "Ceremonial Knife":
                    self?.ceremonialKnifeTypes.append(categoryType)
                case "Fist Weapon":
                    self?.FistTypes.append(categoryType)
                case "Flail":
                    self?.FlailTypes.append(categoryType)
                case "Mighty Weapon":
                    self?.mightyTypes.append(categoryType)
                case "Scythe":
                    self?.scytheTypes.append(categoryType)
                    
                case "Two-Handed Axe":
                    self?.twoHandedAxeTypes.append(categoryType)
                case "Two-Handed Mace":
                    self?.twoHandedMaceTypes.append(categoryType)
                case "Polearm":
                    self?.polearmTypes.append(categoryType)
                case "Staff":
                    self?.staffTypes.append(categoryType)
                case "Two-Handed Sword":
                    self?.twoHandedSwordTypes.append(categoryType)
                case "Daibo":
                    self?.daiboTypes.append(categoryType)
                case "Two-Handed Flail":
                    self?.twoHandedFlailTypes.append(categoryType)
                case "Two-Handed Mighty Weapon":
                    self?.twoHandedMightyTypes.append(categoryType)
                case "Two-Handed Scythe":
                    self?.twoHandedScytheTypes.append(categoryType)
                    
                    
                case "Bow":
                    self?.bowTypes.append(categoryType)
                case "Crossbow":
                    self?.crossbowTypes.append(categoryType)
                case "Hand Crossbow":
                    self?.handedCrossbowTypes.append(categoryType)
                case"Wand":
                    self?.wandTypes.append(categoryType)
                    
                case "Weapon":
                    self?.otherWeapon.append(categoryType)
                    
                case "Helm", "Spirit Stone", "Voodoo Mask", "Wizard Hat":
                    self?.headTypes.append(categoryType)
                case "Shoulders":
                    self?.shoulderTypes.append(categoryType)
                case "Chest Armor", "Cloak":
                    self?.torsoTypes.append(categoryType)
                case "Bracers":
                    self?.wristTypes.append(categoryType)
                case "Gloves":
                    self?.handTypes.append(categoryType)
                case "Belt", "Mighty Belt":
                    self?.waistTypes.append(categoryType)
                case "Pants":
                    self?.legTypes.append(categoryType)
                case "Boots":
                    self?.feetTypes.append(categoryType)
                case "Amulet", "Ring":
                    self?.jewelryTypes.append(categoryType)
                case "Shield","Crusader Shield","Source", "Mojo", "Quiver", "Phylactery":
                    self?.offHandTypes.append(categoryType)
                case "Enchantress Focus", "Scoundrel Token", "Templar Relic":
                    self?.followerTypes.append(categoryType)
                case "Consumable","Potion":
                    self?.consumableTypes.append(categoryType)
                case "Crafting Material", "Blacksmith Plan", "Jeweler Design", "Tome of Training":
                    self?.craftingTypes.append(categoryType)
                case "Dye":
                    self?.dyeTypes.append(categoryType)
                case "Gem":
                    self?.gemTypes.append(categoryType)
                case "Portal Device":
                    self?.miscellaneousTypes.append(categoryType)
                case "Gold":
                    self?.goldTypes.append(categoryType)
                case "Quest":
                    self?.questTypes.append(categoryType)
                case "Shard", "Greater Shard":
                    self?.shardTypes.append(categoryType)
                case "Scroll":
                    self?.questTypes.append(categoryType)
                case "Transmogrify Plan":
                    self?.planTypes.append(categoryType)
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
                        SCNetworkManager.shared.getItemImage(icon: icon, completion: { (image) in
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
            SCNetworkManager.shared.getItemImage(icon: icon, completion: { (image) in
                details.iconImage = image
                completion(details, isSuccess)
            })
            
        }
    }
}

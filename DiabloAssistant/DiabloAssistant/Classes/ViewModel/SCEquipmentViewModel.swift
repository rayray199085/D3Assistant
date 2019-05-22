//
//  SCEquipmentViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 22/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCEquipmentViewModel{
    private var characters = ["Barbarian","Crusader","DemonHunter","Monk","Necromancer","WitchDoctor","Wizard"]
    private var characterName: String?
    
    var equipmentTypes: [SCEquipmentType]?
    var categoryEquipmentTypes: [SCCategoryEquipmentType]?
    
    init(characterName: String?) {
        var characterName = characterName
        characterName?.removeAll(where: { (c) -> Bool in
            return c == " "
        })
        self.characterName = characterName
        characters.removeAll { (name) -> Bool in
            return name == characterName
        }
        print(characterName)
        print(characters)
    }
    
    func loadEquipmentTypeList(completion:@escaping (_ array: [[String: Any]]?, _ isSuccess: Bool)->()){
        SCNetworkManager.shared.getEquipmentTypeList { [weak self] (array, isSuccess) in
            guard let array = array,
                var types = NSArray.yy_modelArray(with: SCEquipmentType.self, json: array) as? [SCEquipmentType] else{
                completion(nil, isSuccess)
                return
            }
            for type in types{
                for name in self?.characters ?? []{
                    if (type.id! as NSString).contains(name){
                        types.removeAll(where: { (ty) -> Bool in
                            return ty == type
                        })
                    }
                }
            }
            print(types)
            print(types.count)
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
            completion(array, isSuccess)
        }
    }
}

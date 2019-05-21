//
//  SCCharacterViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import YYModel

class SCCharacterViewModel {
    private var characterName: String
    
    var character: SCCharacter?{
        didSet{
            guard let categories = character?.skillCategories,
                  let skillArray = character?.skills?.active,
                  let filePath = Bundle.main.path(forResource: "characterSkills", ofType: "plist"),
                  let array = NSArray(contentsOfFile: filePath) as? [[String: Any]] else{
                    return
            }
            var location = 0
            for (index,dict) in array.enumerated(){
                guard let name = dict["name"] as? String else{
                    continue
                }
                if name == characterName{
                    location = index
                    break
                }
            }
            let skills = array[location]["skills"] as? [[String: Any]]
            for dict in skills ?? []{
                let res = skillArray.filter { (skill) -> Bool in
                    return skill.slug == (dict["name"] as? String)
                }
                if res.count > 0{
                    res[0].type = dict["type"] as? String
                }
            }
            
            categorySkills = [[SCActiveSkill]]()
            for category in categories{
                var group = [SCActiveSkill]()
                for skill in skillArray{
                    if skill.type == category.slug{
                        group.append(skill)
                    }
                }
                categorySkills?.append(group)
            }
        }
    }
    
    var categorySkills: [[SCActiveSkill]]?
    
    init(characterName: String) {
        self.characterName = characterName
    }
    func loadCharacter(completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getCharacterInfo(characterName: characterName) { (dict, isSuccess) in
            if !isSuccess{
                completion(isSuccess)
                return
            }
            guard let dict = dict else{
                completion(false)
                return
            }
            let character = SCCharacter.yy_model(with: dict)
            self.loadSkillImage(character: character,completion: completion)
        }
    }
    
    private func loadSkillImage(character: SCCharacter?,completion:@escaping (_ isSuccess: Bool)->()){
        guard let character = character,
              let activeSkills = character.skills?.active,
              let passiveSkills = character.skills?.passive else{
            completion(false)
            return
        }
        
        let group = DispatchGroup()
        for skill in activeSkills{
            guard let icon = skill.icon else{
                continue
            }
            group.enter()
            SCNetworkManager.shared.getSkillImage(icon: icon) { (image) in
                skill.skillImage = image
                group.leave()
            }
            
        }
        
        for skill in passiveSkills{
            guard let icon = skill.icon else{
                continue
            }
            group.enter()
            SCNetworkManager.shared.getSkillImage(icon: icon) { (image) in
                skill.skillImage = image
                group.leave()
            }
        }
        
        for skill in activeSkills{
            guard let skillSlug = skill.slug,
                let characterSlug = character.slug else {
                    continue
            }
            group.enter()
            SCNetworkManager.shared.getSkillRunes(skillSlug: skillSlug, characterSlug: characterSlug) { (array, isSuccess) in
                if let json = array,
                   let runes = NSArray.yy_modelArray(with: SCRunes.self, json: json) as? [SCRunes]{
                    skill.runes = runes
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.character = character
            completion(true)
        }
    }
}

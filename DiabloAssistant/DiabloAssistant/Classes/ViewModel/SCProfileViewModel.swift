//
//  SCProfileViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import YYModel

class SCProfileViewModel{
    var heroId: String?
    var playerRegion: String?
    var playerBattleTag: String?
    
    var heroStatsDescription: String?
    
    var heroEquips: SCProfileEquipments?{
        didSet{
            
        }
    }
    
    var heroSkills: SCProfileHeroSkills?{
        didSet{
            
        }
    }
    var followers: SCProfileFollowerList?{
        didSet{
            
        }
    }
    var heroStats: SCProfileHeroStats?{
        didSet{
            guard let text = heroStats?.description else{
                return
            }
            var location: Int = 0
            for (index,c) in text.enumerated(){
                if c == "{"{
                    location = index
                    break
                }
            }
            var statistics = (text as NSString).substring(with: NSRange(location: location + 1, length: text.count - location - 2))
            statistics.removeAll { (c) -> Bool in
                return c == ";"
            }
            statistics = (statistics as NSString).replacingOccurrences(of: " =", with: ":")
            statistics = statistics.trimmingCharacters(in: NSCharacterSet.newlines)
            heroStatsDescription = statistics.uppercased()
        }
    }
    var legendaryPowers: [SCProfileLegendaryPowerItem]?{
        didSet{
            
        }
    }
    
    init() {
        
    }
    func loadPlayerProfile(region: String, battleTag: String, completion:@escaping (_ profileData: SCProfileData?,_ isSuccess: Bool)->()){
        playerRegion = region
        playerBattleTag = battleTag
        SCNetworkManager.shared.getPlayerProfile(region: region, battleTag: battleTag) { (dict, isSuccess) in
            guard let dict = dict else{
                completion(nil, false)
                return
            }
            let profileData = SCProfileData.yy_model(with: dict)
            completion(profileData, true)
        }
    }
    
    func loadHeroDetails(id: String?, completion:@escaping (_ isSuccess: Bool)->()){
        guard let region = playerRegion,
            let battleTag = playerBattleTag,
            let id = id else{
                completion(false)
                return
        }
        heroId = id
        SCNetworkManager.shared.getHeroDetails(region: region, battleTag: battleTag, id: id) { (dict, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let dict = dict,
                let skills = dict["skills"] as? [String: Any],
                let followers = dict["followers"] as? [String: Any],
                let heroStats = dict["stats"] as? [String: Any],
                let legendaryPowers = dict["legendaryPowers"] as? [[String: Any]],
                let powerArray = NSArray.yy_modelArray(with: SCProfileLegendaryPowerItem.self, json: legendaryPowers) as? [SCProfileLegendaryPowerItem]
                else{
                completion(false)
                return
            }
            self.heroSkills = SCProfileHeroSkills.yy_model(with: skills)
            self.followers = SCProfileFollowerList.yy_model(with: followers)
            self.heroStats = SCProfileHeroStats.yy_model(with: heroStats)
            let group = DispatchGroup()
            for power in powerArray{
                guard let icon = power.icon else{
                    continue
                }
                group.enter()
                SCNetworkManager.shared.getItemImage(icon: icon, size: SCItemImageSize.large, completion: { (image) in
                    power.iconImage = image
                    group.leave()
                })
            }
            group.notify(queue: DispatchQueue.main, execute: {
                self.legendaryPowers = powerArray
                completion(true)
            })
        }
    }
    
    func loadEquipmentDetails(slugId: String,completion: @escaping (_ details: SCEquipmentItemDetails?, _ isSuccess: Bool)->()){
        SCNetworkManager.shared.getProfileEquipmentDetails(slugId: slugId) { (dict, isSuccess) in
            if !isSuccess{
                completion(nil, false)
                return
            }
            guard let dict = dict,
                let details = SCEquipmentItemDetails.yy_model(with: dict) else{
                    completion(nil, isSuccess)
                    return
            }
            completion(details, isSuccess)
        }
    }
    
    func loadEquipmentItems(completion:@escaping (_ isSuccess: Bool)->()){
        guard let region = playerRegion,
            let battleTag = playerBattleTag,
            let id = heroId else{
                completion(false)
                return
        }
        SCNetworkManager.shared.getProfileEquipments(region: region, battleTag: battleTag, heroId: id) { (dict, isSuccess) in
            guard let dict = dict,
                  let equips = SCProfileEquipments.yy_model(with: dict) else{
                return
            }
            let group = DispatchGroup()
            for item in equips.items ?? []{
                guard let item = item,
                      let icon = item.icon else{
                    continue
                }
                group.enter()
                SCNetworkManager.shared.getItemImage(icon: icon, size: SCItemImageSize.large, completion: { (image) in
                    item.iconImage = image
                    group.leave()
                })
                for gem in item.gems ?? []{
                    guard let gemIcon = gem.item?.icon else{
                        continue
                    }
                    group.enter()
                    SCNetworkManager.shared.getItemImage(icon: gemIcon, size: SCItemImageSize.small, completion: { (image) in
                        gem.item?.iconImage = image
                        group.leave()
                    })
                }
            }
            group.notify(queue: DispatchQueue.main, execute: {
                self.heroEquips = equips
                completion(true)
            })
        }
    }
    func loadSkillimages(completion:@escaping (_ isSuccess:Bool)->()){
        let group = DispatchGroup()
        for active in heroSkills?.active ?? []{
            guard let icon = active.skill?.icon else{
                continue
            }
            group.enter()
            SCNetworkManager.shared.getSkillImage(icon: icon) { (image) in
                active.skill?.skillImage = image
                group.leave()
            }
        }
        for passive in heroSkills?.passive ?? []{
            guard let icon = passive.skill?.icon else{
                continue
            }
            group.enter()
            SCNetworkManager.shared.getSkillImage(icon: icon) { (image) in
                passive.skill?.skillImage = image
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            completion(true)
        }
    }
    func loadFollowerInfo(completion:@escaping (_ isSuccess: Bool)->()){
        guard let region = playerRegion,
            let battleTag = playerBattleTag,
            let id = heroId else{
                completion(false)
                return
        }
        SCNetworkManager.shared.getProfileFollowerItems(region: region, battleTag: battleTag, heroId: id) { (dict, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let dict = dict,
                  let details = SCProfileFollowerItemDetails.yy_model(with: dict) else{
                completion(false)
                return
            }
            self.followers?.scoundrel?.items = details.scoundrel
            self.followers?.templar?.items = details.templar
            self.followers?.enchantress?.items = details.enchantress
            let group = DispatchGroup()
            for follower in self.followers?.followers ?? []{
                for skill in follower?.skills ?? []{
                    guard let icon = skill.icon else{
                        continue
                    }
                    group.enter()
                    SCNetworkManager.shared.getSkillImage(icon: icon, completion: { (image) in
                        skill.skillImage = image
                        group.leave()
                    })
                }
                for item in follower?.items?.items ?? []{
                    guard let item = item,
                          let icon = item.icon else{
                        continue
                    }
                    group.enter()
                    SCNetworkManager.shared.getItemImage(icon: icon, size: SCItemImageSize.large, completion: { (image) in
                        item.iconImage = image
                        group.leave()
                    })
                    for gem in item.gems ?? []{
                        guard let gemIcon = gem.item?.icon else{
                            continue
                        }
                        group.enter()
                        SCNetworkManager.shared.getItemImage(icon: gemIcon, size: SCItemImageSize.small, completion: { (image) in
                            gem.item?.iconImage = image
                            group.leave()
                        })
                    }
                }
            }
            group.notify(queue: DispatchQueue.main, execute: {
                completion(true)
            })
        }
    }
}

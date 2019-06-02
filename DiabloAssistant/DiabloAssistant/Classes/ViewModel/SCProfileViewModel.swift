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
    var heroStatsDescription: String?
    
    var heroSkills: SCProfileHeroSkills?{
        didSet{
            
        }
    }
    var heroEquipments: SCProfileEquipments?{
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
        SCNetworkManager.shared.getPlayerProfile(region: region, battleTag: battleTag) { (dict, isSuccess) in
            guard let dict = dict else{
                completion(nil, false)
                return
            }
            let profileData = SCProfileData.yy_model(with: dict)
            completion(profileData, true)
        }
    }
    
    func loadHeroDetails(region: String?,battleTag: String?, id: String?, completion:@escaping (_ isSuccess: Bool)->()){
        guard let region = region,
            let battleTag = battleTag,
            let id = id else{
                completion(false)
                return
        }
        SCNetworkManager.shared.getHeroDetails(region: region, battleTag: battleTag, id: id) { (dict, isSuccess) in
            if !isSuccess{
                completion(false)
                return
            }
            guard let dict = dict,
                let skills = dict["skills"] as? [String: Any],
                let equipments = dict["items"] as? [String: Any],
                let followers = dict["followers"] as? [String: Any],
                let heroStats = dict["stats"] as? [String: Any],
                let legendaryPowers = dict["legendaryPowers"] as? [[String: Any]],
                let powerArray = NSArray.yy_modelArray(with: SCProfileLegendaryPowerItem.self, json: legendaryPowers) as? [SCProfileLegendaryPowerItem]
                else{
                completion(false)
                return
            }
            self.heroSkills = SCProfileHeroSkills.yy_model(with: skills)
            self.heroEquipments = SCProfileEquipments.yy_model(with: equipments)
            self.followers = SCProfileFollowerList.yy_model(with: followers)
            self.heroStats = SCProfileHeroStats.yy_model(with: heroStats)
            self.legendaryPowers = powerArray
            completion(true)
        }
    }
}

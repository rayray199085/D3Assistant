//
//  SCNetworkManager+extension.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 15/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
enum SCItemImageSize {
    case small
    case large
}
extension SCNetworkManager{
    func getAccessToken(code: String,completion:@escaping (_ isSuccess: Bool)->()){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
            return
        }
        print(region)
        let urlString = "https://\(region).battle.net/oauth/token"
        let params = ["client_id": SCClientId,
                      "client_secret": SCClientSecret,
                      "grant_type": "authorization_code",
                      "code":code,
                      "redirect_uri": SCRedirectURL]
       
        request(urlString: urlString, method: HTTPMethod.post, params: params) { (res, isSuccess, statusCode, error) in
            guard let tokenDict = res as? [String: Any] else{
                completion(false)
                return
            }
            self.userAccount.yy_modelSet(with: tokenDict)
            self.userAccount.saveUserInfo()
            SVProgressHUD.showInfo(withStatus: "Login Success!")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                completion(isSuccess)
            })
        }
    }
}


// MARK: - load character info
extension SCNetworkManager{
    func getCharacterInfo(characterName: String,completion:@escaping (_ dict:[String: Any]?, _ isSuccess: Bool)->()){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
            completion(nil,false)
            return
        }
        let urlString = "https://\(region).api.blizzard.com/d3/data/hero/\(characterName)"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict,isSuccess)
        }
    }
    
    func getSkillRunes(skillSlug: String, characterSlug: String,completion:@escaping (_ array: [[String: Any]]?, _ isSuccess: Bool)->()){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
            completion(nil,false)
            return
        }
        let urlString = "https://\(region).api.blizzard.com/d3/data/hero/\(characterSlug)/skill/\(skillSlug)"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String: Any]
            let array = dict?["runes"] as? [[String: Any]]
            completion(array,isSuccess)
        }
    }
}

extension SCNetworkManager{
    
    /// get skill icon image
    ///
    /// - Parameter icon: skill icon name
    func getSkillImage(icon: String,completion:@escaping (_ image: UIImage?)->()){
        let urlString = "http://media.blizzard.com/d3/icons/skills/64/\(icon).png"
        guard let url = URL(string: urlString) else{
            completion(nil)
            return
        }
        UIImage.downloadImage(url: url) { (image) in
            completion(image)
        }
    }
}


// MARK: - load equipment info
extension SCNetworkManager{
    func getEquipmentTypeList(completion:@escaping (_ array: [[String: Any]]?, _ isSuccess: Bool)->()){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
            completion(nil,false)
            return
        }
        let urlString = "https://\(region).api.blizzard.com/d3/data/item-type"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let array = res as? [[String: Any]]
            completion(array, isSuccess)
        }
    }
    
    func getEquipmentType(type: String, completion:@escaping (_ array: [[String: Any]]?, _ isSuccess: Bool)->()){
        var type = type
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
            completion(nil,false)
            return
        }
        type = (type as NSString).replacingOccurrences(of: "_", with: "")
        let urlString = "https://\(region).api.blizzard.com/d3/data/item-type/\(type.lowercased())"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let array = res as? [[String: Any]]
            completion(array, isSuccess)
        }
    }
    
    func getItemImage(icon: String,size: SCItemImageSize, completion:@escaping (_ image: UIImage?)->()){
        let iconSize = size == SCItemImageSize.large ? "large" : "small"
        let urlString = "http://media.blizzard.com/d3/icons/items/\(iconSize)/\(icon).png"
        guard let url = URL(string: urlString) else{
            completion(nil)
            return
        }
        UIImage.downloadImage(url: url) { (image) in
            completion(image)
        }
    }
    
    func getItemDetails(item: SCEquipmentItem, completion:@escaping (_ dict: [String: Any]?,_ isSuccess: Bool)->()){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String,
              let slug = item.slug,
              let id = item.id  else{
            completion(nil,false)
            return
        }
        let urlString = "https://\(region).api.blizzard.com/d3/data/item/\(slug)-\(id)"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) {(res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict, isSuccess)
        }
    }
}


// MARK: - load follower info
extension SCNetworkManager{
    func getFollowerSkills(followerName: String,completion:@escaping (_ dict: [String: Any]?, _ isSuccess: Bool)->()){
        let urlString = "https://us.api.blizzard.com/d3/data/follower/\(followerName)"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict, isSuccess)
        }
    }
}

// MARK: - load player profile
extension SCNetworkManager{
    func getPlayerProfile(region: String, battleTag: String, completion:@escaping (_ dict: [String: Any]?, _ isSuccess: Bool)->()){
        let urlString = "https://\(region.lowercased()).api.blizzard.com/d3/profile/\(getUrlBattleTag(tag: battleTag))/"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String:Any]
            completion(dict, isSuccess)
        }
    }
    
    func getHeroDetails(region: String, battleTag: String, id: String, completion:@escaping (_ dict: [String: Any]?,_ isSuccess: Bool)->()){
        let urlString = "https://\(region).api.blizzard.com/d3/profile/\(getUrlBattleTag(tag: battleTag))/hero/\(id)"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict, isSuccess)
        }
    }
    
    func getUrlBattleTag(tag: String)->String{
        var battleTag = tag
        battleTag = (battleTag as NSString).replacingOccurrences(of: " ", with: "")
        battleTag = (battleTag as NSString).replacingOccurrences(of: "#", with: "-")
        return battleTag
    }
    
    func getProfileEquipmentDetails(slugId: String, completion:@escaping (_ dict: [String: Any]?,_ isSuccess: Bool)->()){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
                completion(nil,false)
                return
        }
        let urlString = "https://\(region).api.blizzard.com/d3/data/item/\(slugId)"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) {(res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict, isSuccess)
        }
    }
    
    func getProfileEquipments(region: String, battleTag: String, heroId: String,completion: @escaping (_ dict: [String: Any]?,_ isSuccess: Bool)->()){
        let urlString = "https://\(region).api.blizzard.com/d3/profile/\(battleTag)/hero/\(heroId)/items"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict, isSuccess)
        }
    }
    
    func getProfileFollowerItems(region: String, battleTag: String, heroId: String,completion: @escaping (_ dict: [String: Any]?,_ isSuccess: Bool)->()){
        let urlString = "https://\(region).api.blizzard.com/d3/profile/\(battleTag)/hero/\(heroId)/follower-items"
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: nil) { (res, isSuccess) in
            let dict = res as? [String: Any]
            completion(dict, isSuccess)
        }
    }
}

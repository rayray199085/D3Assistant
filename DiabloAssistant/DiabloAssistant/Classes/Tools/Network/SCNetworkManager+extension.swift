//
//  SCNetworkManager+extension.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 15/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire

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
            completion(isSuccess)
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

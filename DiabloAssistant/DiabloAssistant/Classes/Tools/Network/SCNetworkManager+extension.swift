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

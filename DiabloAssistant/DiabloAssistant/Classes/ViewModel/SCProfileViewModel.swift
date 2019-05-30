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
}

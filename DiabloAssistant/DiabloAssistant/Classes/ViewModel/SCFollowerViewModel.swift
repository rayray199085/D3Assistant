//
//  SCFollowerViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCFollowerViewModel{
    init() {
        
    }
    func loadFollowerInfo(followerName: String, completion:@escaping (_ followerInfo : SCFollowerInfo?,_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getFollowerSkills(followerName: followerName) { (dict, isSuccess) in
            guard let dict = dict,
                  let follower = SCFollowerInfo.yy_model(with: dict) else{
                  completion(nil, false)
                return
            }
            let group = DispatchGroup()
            for skill in follower.skills ?? []{
                guard let icon = skill.icon else{
                    continue
                }
                group.enter()
                SCNetworkManager.shared.getSkillImage(icon: icon, completion: { (image) in
                    skill.iconImage = image
                    group.leave()
                })
            }
            group.notify(queue: DispatchQueue.main, execute: {
                completion(follower,true)
            })
        }
    }
}

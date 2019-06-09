//
//  SCFollowerViewModel.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCFollowerViewModel{
    lazy var followerInfo = [String: SCFollowerInfo?]()
    private let names = ["templar", "scoundrel", "enchantress"]
    
    func loadFollowerInfo(followerName: String, completion:@escaping (_ followerInfo : SCFollowerInfo?,_ isSuccess: Bool)->()){
        let group = DispatchGroup()
        for name in names{
            group.enter()
            SCNetworkManager.shared.getFollowerSkills(followerName: name) { (dict, isSuccess) in
                guard let dict = dict,
                    let follower = SCFollowerInfo.yy_model(with: dict) else{
                        completion(nil, false)
                        return
                }
                self.followerInfo[name] = follower
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
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main, execute: {
            completion(self.followerInfo[followerName]!,true)
        })
    }
}

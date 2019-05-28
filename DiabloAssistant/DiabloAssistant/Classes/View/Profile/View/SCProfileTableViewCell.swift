//
//  SCProfileTableViewCell.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileTableViewCell: UITableViewCell {
    
    var profileInfo: SCProfileInfo?{
        didSet{
            profileIcon.image = UIImage(named: "profile_\(profileInfo?.slug ?? "")_\(profileInfo?.gender ?? "")")
            roleNameLabel.text = "Name: \(profileInfo?.name ?? "")"
            levelLabel.text = "Level: \(profileInfo?.level ?? 1)"
            classNameLabel.text = "Class: \(profileInfo?.classes ?? "")"
        }
    }
    
    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var roleNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

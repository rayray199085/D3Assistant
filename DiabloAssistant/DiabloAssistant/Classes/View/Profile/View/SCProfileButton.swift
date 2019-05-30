//
//  SCProfileButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileButton: UIView {
    var hero: SCProfileHero?{
        didSet{
            frameImageView.image = UIImage(named: "profile_\(hero?.gender ?? 0)_bg")
            iconButton.setBackgroundImage(UIImage(named: "profile_\(hero?.classSlug ?? "")_\(hero?.gender ?? 0)"), for: [])
            nameLabel.text = hero?.name
            levelLabel.text = "\(hero?.level ?? 1)"
        }
    }
    
    @IBOutlet weak var frameImageView: UIImageView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    class func profileButton()->SCProfileButton{
        let nib = UINib(nibName: "SCProfileButton", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileButton
        v.frame = CGRect(x: 0, y: 0, width: 106, height: 106)
        return v
    }
    @IBAction func clickIconButton(_ sender: Any) {
        print(hero?.id ?? "")
    }
}

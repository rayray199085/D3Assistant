//
//  SCActiveSkillView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCActiveSkillView: UIView {
    @IBOutlet weak var skillOptionButton: UIButton!
    @IBOutlet weak var runeIcon: UIImageView!
    @IBOutlet weak var runeName: UILabel!
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var controlImageView: UIImageView!
    @IBOutlet weak var activeSkillImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    class func activeSkillView()->SCActiveSkillView{
        let nib = UINib(nibName: "SCActiveSkillView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCActiveSkillView
        v.frame = CGRect(x: 0, y: 0, width: 180, height: 84)
        return v
    }
    
    override func awakeFromNib() {
        
    }
}

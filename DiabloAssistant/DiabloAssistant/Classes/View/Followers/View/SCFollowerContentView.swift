//
//  SCFollowerContentView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 27/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import ExpandingMenu

class SCFollowerContentView: UIView {

    @IBOutlet var skillButtons: [UIButton]!
    class func contentView()->SCFollowerContentView{
        let nib = UINib(nibName: "SCFollowerContentView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCFollowerContentView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {

    }
    
    
    @IBAction func clickSkillButton(_ sender: UIButton) {
        print(sender.tag)
    }
}


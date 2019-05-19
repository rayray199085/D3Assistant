//
//  SCActiveSkillsIntroView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCActiveSkillsIntroView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skillView: UIView!
    @IBOutlet weak var runeView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    class func skillIntroView()->SCActiveSkillsIntroView{
        let nib = UINib(nibName: "SCActiveSkillsIntroView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCActiveSkillsIntroView
        v.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
        return v
    }
    
    @IBAction func clickRightButton(_ sender: Any) {
    }
    
    @IBAction func clickLeftButton(_ sender: Any) {
    }
}

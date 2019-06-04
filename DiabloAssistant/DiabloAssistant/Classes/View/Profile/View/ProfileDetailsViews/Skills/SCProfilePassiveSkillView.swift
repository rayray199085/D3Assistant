//
//  SCProfilePassiveSkillView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfilePassiveSkillView: UIView {

    class func skillView()->SCProfilePassiveSkillView{
        let nib = UINib(nibName: "SCProfilePassiveSkillView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfilePassiveSkillView
        v.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        return v
    }
    
    @IBOutlet weak var skillIconButton: UIButton!
    @IBAction func clickSkillIconButton(_ sender: Any) {
    }
}

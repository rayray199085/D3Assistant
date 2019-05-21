//
//  SCPassiveSkillItemView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 21/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCPassiveSkillItemView: UIView {

    @IBOutlet weak var passiveSkillButton: UIButton!
    @IBOutlet weak var iconMaskView: UIView!
    @IBOutlet weak var selectedSkillFrame: UIImageView!
    
    class func skillItemView()->SCPassiveSkillItemView{
        let nib = UINib(nibName: "SCPassiveSkillItemView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCPassiveSkillItemView
        v.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return v
    }
    
    override func awakeFromNib() {
        iconMaskView.layer.cornerRadius = bounds.width * 0.5
        iconMaskView.layer.masksToBounds = true
        cancelSelectedItem()
    }
    
    func didSeletedItem(){
        iconMaskView.isHidden = false
        selectedSkillFrame.isHidden = false
    }
    
    func cancelSelectedItem(){
        iconMaskView.isHidden = true
        selectedSkillFrame.isHidden = true
    }
}

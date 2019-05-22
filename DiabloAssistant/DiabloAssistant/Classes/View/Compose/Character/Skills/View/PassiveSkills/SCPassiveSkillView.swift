//
//  SCPassiveSkillView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCPassiveSkillView: UIView {
    // for removing selection 
    var passiveSkillIndex: Int = 0
    @IBOutlet weak var requiredLevel: UILabel!
    @IBOutlet weak var passiveSkillImageView: UIImageView!
    @IBOutlet weak var passiveFrameButton: UIButton!
    
    class func passiveSkillView()->SCPassiveSkillView{
        let nib = UINib(nibName: "SCPassiveSkillView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCPassiveSkillView
        v.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        return v
    }
    func setLevel(level: Int){
        requiredLevel.text = "\(level)"
    }
    
    func didSelected(){
        passiveFrameButton.isSelected = true
        requiredLevel.textColor = UIColor.white
    }
    
    func cancelSelection(){
         passiveFrameButton.isSelected = false
         requiredLevel.textColor = SCButtonTitleColor
    }
    func isSelected()->Bool{
        return passiveSkillImageView.image != nil
    }
    
    func resetSkillView(){
        cancelSelection()
        passiveSkillImageView.image = nil
    }
}

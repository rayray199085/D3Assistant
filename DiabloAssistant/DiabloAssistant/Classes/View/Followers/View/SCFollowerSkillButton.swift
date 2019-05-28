//
//  SCFollowerSkillButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 28/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCFollowerSkillButtonDelegate: NSObjectProtocol {
    func didClickIconButton(view: SCFollowerSkillButton, tag: Int)
    func didClickFrameButton(view: SCFollowerSkillButton, tag: Int)
    func didClickMaskButton(view: SCFollowerSkillButton, tag: Int)
    
}
class SCFollowerSkillButton: UIView {
    @IBOutlet weak var skillIconButton: UIButton!
    @IBOutlet weak var skillMaskButton: UIButton!
    @IBOutlet weak var skillFrameButton: UIButton!
    
    var skill: SCFollowerSkill?{
        didSet{
            setButtonEnable()
            setIconImage(image: skill?.iconImage)
        }
    }
    weak var delegate: SCFollowerSkillButtonDelegate?
    
    class func skillButton()->SCFollowerSkillButton{
        let nib = UINib(nibName: "SCFollowerSkillButton", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCFollowerSkillButton
        v.frame = CGRect(x: 0, y: 0, width: 42, height: 41)
        v.clearButtonContent()
        return v
    }
    
    func hideMaskAndFrame(){
        skillFrameButton.isHidden = true
        skillMaskButton.isHidden = true
    }
    func setMaskOn(){
        skillMaskButton.isHidden = false
    }
    func setFrameOn(){
        skillFrameButton.isHidden = false
    }
    
    @IBAction func clickSkillFrameButton(_ sender: UIButton) {
        delegate?.didClickFrameButton(view: self, tag: tag)
    }
    @IBAction func clickSkillMaskButton(_ sender: UIButton) {
        delegate?.didClickMaskButton(view: self, tag: tag)
    }
    @IBAction func clickSkilIconButton(_ sender: UIButton) {
        delegate?.didClickIconButton(view: self, tag: tag)
    }
    
    func clearButtonContent(){
        skillIconButton.setImage(nil, for: [])
        hideMaskAndFrame()
        skillIconButton.isUserInteractionEnabled = false
        skillMaskButton.isUserInteractionEnabled = false
        skillFrameButton.isUserInteractionEnabled = false
    }
    
    func setIconImage(image: UIImage?){
        skillIconButton.setImage(image, for: [])
    }
    
    func setButtonEnable(){
        skillIconButton.isUserInteractionEnabled = true
        skillMaskButton.isUserInteractionEnabled = true
        skillFrameButton.isUserInteractionEnabled = true
    }
}

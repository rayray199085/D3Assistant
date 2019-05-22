//
//  SCPassiveSkillItemView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 21/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCPassiveSkillItemViewDelegate: NSObjectProtocol {
    func didClickPassiveSkillButton(view: SCPassiveSkillItemView, index: Int)
}
class SCPassiveSkillItemView: UIView {
    weak var delegate: SCPassiveSkillItemViewDelegate?
    
    @IBOutlet weak var passiveSkillButton: UIButton!
    @IBOutlet weak var iconMaskView: UIView!
    @IBOutlet weak var selectedFrameButton: UIButton!
    
    class func skillItemView()->SCPassiveSkillItemView{
        let nib = UINib(nibName: "SCPassiveSkillItemView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCPassiveSkillItemView
        v.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return v
    }
    
    override func awakeFromNib() {
        iconMaskView.layer.cornerRadius = bounds.width * 0.5
        iconMaskView.layer.masksToBounds = true
        selectedFrameButton.adjustsImageWhenHighlighted = false
        cancelSelectedItem()
    }
    
    func didSeletedItem(){
        iconMaskView.isHidden = false
        selectedFrameButton.isHidden = false
    }
    
    func cancelSelectedItem(){
        iconMaskView.isHidden = true
        selectedFrameButton.isHidden = true
    }
    
    func isSelected()->Bool{
        return !iconMaskView.isHidden
    }
    @IBAction func clickSelectedFrameButton(_ sender: Any) {
    }
    
    @IBAction func clickPassiveSkillButton(_ sender: UIButton) {
        didSeletedItem()
        delegate?.didClickPassiveSkillButton(view: self, index: sender.tag)
    }
}

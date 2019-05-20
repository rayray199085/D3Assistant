//
//  SCActiveSkillItemView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 20/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCActiveSkillItemViewDelegate:NSObjectProtocol {
    func didClickSkillButton(view: SCActiveSkillItemView, tag: Int)
}
class SCActiveSkillItemView: UIView {    
    @IBOutlet weak var skillButton: UIButton!
    @IBOutlet weak var skillMask: UIView!
    @IBOutlet weak var selectedFrame: UIImageView!
    
    weak var delegate: SCActiveSkillItemViewDelegate?
    
    class func skillItemView()->SCActiveSkillItemView{
        let nib = UINib(nibName: "SCActiveSkillItemView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCActiveSkillItemView
        v.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return v
    }
    override func awakeFromNib() {
        cancelSelection()
    }
    
    func cancelSelection(){
        skillMask.isHidden = true
        selectedFrame.isHidden = true
    }
    
    func didSelected(){
        skillMask.isHidden = false
        selectedFrame.isHidden = false
    }
    @IBAction func clickSkillButton(_ sender: UIButton) {
        delegate?.didClickSkillButton(view: self, tag: sender.tag)
    }
}

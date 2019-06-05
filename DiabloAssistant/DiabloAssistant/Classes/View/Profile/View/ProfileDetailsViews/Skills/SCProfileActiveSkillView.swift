//
//  SCProfileActiveSkillView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCProfileActiveSkillViewDelegate: NSObjectProtocol {
    func didClickActiveSkillButton(view: SCProfileActiveSkillView, index: Int)
}
class SCProfileActiveSkillView: UIView {
    weak var delegate: SCProfileActiveSkillViewDelegate?
    
    var activeSkill: SCProfileHeroActive?{
        didSet{
            runeNameLabel.text = activeSkill?.rune?.name
            skillNameLabel.text = activeSkill?.skill?.name
            skillIconButton.setImage(activeSkill?.skill?.skillImage, for: [])
        }
    }
    
    @IBOutlet weak var runeNameLabel: UILabel!
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var positionImageView: UIImageView!
    @IBOutlet weak var skillIconButton: UIButton!
    
    class func skillView(index: Int)->SCProfileActiveSkillView{
        let nib = UINib(nibName: "SCProfileActiveSkillView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileActiveSkillView
        v.frame = CGRect(x: 0, y: 0, width: 170, height: 45)
        v.positionImageView.image = UIImage(named: "active_skill_\(index)")
        return v
    }
    
    @IBAction func clickSkillIconButton(_ sender: Any) {
        delegate?.didClickActiveSkillButton(view: self, index: tag)
    }
}

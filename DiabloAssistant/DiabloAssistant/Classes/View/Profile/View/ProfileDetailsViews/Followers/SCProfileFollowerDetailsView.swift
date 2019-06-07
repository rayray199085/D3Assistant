//
//  SCProfileFollowerDetailsView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 6/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCProfileFollowerDetailsViewDelegate: NSObjectProtocol {
    func didClickSkillButton(view: SCProfileFollowerDetailsView, skill: SCProfileSkillItem?)
    func didClickEquipButton(view: SCProfileFollowerDetailsView, item: SCProfileEquipmentItem?)
}
class SCProfileFollowerDetailsView: UIView {
    weak var delegate: SCProfileFollowerDetailsViewDelegate?
    var follower: SCProfileFollower?{
        didSet{
            resetSkillButtonImages()
            for (index,skill) in (follower?.skills ?? []).enumerated(){
                skillButtons[index].skill = skill
                skillNameLabels[index].text = skill.name
            }
            for (index,btn) in equipButtons.enumerated(){
                switch btn.tag{
                //main hand
                case 201:
                    btn.item = follower?.items?.mainHand
                //off hand
                case 202:
                    btn.item = follower?.items?.offHand
                // left ring
                case 203:
                    btn.item = follower?.items?.leftFinger
                // right ring
                case 204:
                    btn.item = follower?.items?.rightFinger
                // neck
                case 205:
                    btn.item = follower?.items?.neck
                // special
                case 206:
                    btn.item = follower?.items?.special
                    specialBorderImageView.isHidden = btn.item == nil
                default:
                    break
                }
                setEquipButtonGems(index: index, btn: btn, item: btn.item)
            }
            statsLabels[0].text = "\(follower?.stats?.goldFind ?? 0).00%"
            setLabelTextColor(index: 0, value: follower?.stats?.goldFind ?? 0)
            statsLabels[1].text = "\(follower?.stats?.magicFind ?? 0).00%"
            setLabelTextColor(index: 1, value: follower?.stats?.magicFind ?? 0)
            statsLabels[2].text = "+\(follower?.stats?.experienceBonus ?? 0).00"
            setLabelTextColor(index: 2, value: follower?.stats?.experienceBonus ?? 0)
        }
    }
    
    @IBOutlet var specialBorderImageView: UIImageView!
    @IBOutlet var skillNameLabels: [UILabel]!
    @IBOutlet var skillButtons: [SCProfileFollowerSkillButton]!
    @IBOutlet var equipButtons: [SCProfileFollowerEquipButton]!
    @IBOutlet var statsLabels: [UILabel]!
    @IBOutlet var statsNameLabels: [UILabel]!
    
    
     // clear previous content
    func resetSkillButtonImages(){
        for btn in skillButtons{
            btn.clearPreviousContent()
            btn.setBackgroundImage(UIImage(named: "follower-skill-unlocked"), for: [])
        }
        for lbl in skillNameLabels{
            lbl.text?.removeAll()
        }
        for v in subviews{
            if v.isKind(of: SCProfileEquipGemView.self){
                v.removeFromSuperview()
            }
        }
        for btn in equipButtons{
            btn.item = nil
            btn.setImage(nil, for: [])
            btn.setBackgroundImage(nil, for: [])
        }
    }
    
    @IBAction func clickSkillButton(_ sender: SCProfileFollowerSkillButton){
        delegate?.didClickSkillButton(view: self, skill: sender.skill)
    }
    @IBAction func clickEquipButton(_ sender: SCProfileFollowerEquipButton){
        delegate?.didClickEquipButton(view: self, item: sender.item)
    }
    
}
private extension SCProfileFollowerDetailsView{
    func setEquipButtonGems(index: Int,btn: UIButton, item: SCProfileEquipmentItem?){
        guard let gems = item?.gems else{
            return
        }
        for (i,gem) in gems.enumerated(){
            let gemView = SCProfileEquipGemView.gemView(index: index)
            gemView.delegate = self
            gemView.setGemImage(image: gem.item?.iconImage)
            gemView.center = CGPoint(x: btn.center.x, y: btn.frame.minY + CGFloat(i + 1) / CGFloat(gems.count + 1) * btn.bounds.height)
           addSubview(gemView)
        }
    }
}
extension SCProfileFollowerDetailsView: SCProfileEquipGemViewDelegate{
    func didClickGemButton(view: SCProfileEquipGemView, index: Int) {
        clickEquipButton(equipButtons[index])
    }
}
private extension SCProfileFollowerDetailsView{
    func setLabelTextColor(index: Int, value: Int){
        if value > 0{
            statsLabels[index].textColor = SCProfileStatsNameHighlightedColor
            statsNameLabels[index].textColor = SCProfileStatsNameHighlightedColor
        }else{
            statsLabels[index].textColor = SCProfileStatsNameNormalColor
            statsNameLabels[index].textColor = SCProfileStatsNameNormalColor
        }
    }
}

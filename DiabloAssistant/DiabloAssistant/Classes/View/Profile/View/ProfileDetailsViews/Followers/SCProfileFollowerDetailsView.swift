//
//  SCProfileFollowerDetailsView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 6/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCProfileFollowerDetailsViewDelegate: NSObjectProtocol {
    func didClickSkillButton(view: SCProfileFollowerDetailsView, index: Int)
    func didClickEquipButton(view: SCProfileFollowerDetailsView, index: Int)
}
class SCProfileFollowerDetailsView: UIView {
    weak var delegate: SCProfileFollowerDetailsViewDelegate?
    var follower: SCProfileFollower?{
        didSet{
            resetSkillButtonImages()
            for (index,skill) in (follower?.skills ?? []).enumerated(){
                skillButtons[index].setBackgroundImage(skill.skillImage, for: [])
                skillNameLabels[index].text = skill.name
            }
            for (index,btn) in equipButtons.enumerated(){
                switch btn.tag{
                //main hand
                case 201:
                    btn.setImage(follower?.items?.mainHand?.iconImage?
                    .withRenderingMode(.alwaysOriginal), for: [])
                    btn.setBackgroundImage(UIImage(named: "color_\(follower?.items?.mainHand?.displayColor ?? "")"), for: [])
                    setEquipButtonGems(index: index, btn: btn, item: follower?.items?.mainHand)
                //off hand
                case 202:
                    btn.setImage(follower?.items?.offHand?.iconImage?.withRenderingMode(
                        .alwaysOriginal), for: [])
                    btn.setBackgroundImage(UIImage(named: "color_\(follower?.items?.offHand?.displayColor ?? "")"), for: [])
                    setEquipButtonGems(index: index, btn: btn, item: follower?.items?.offHand)
                // left ring
                case 203:
                    btn.setImage(follower?.items?.leftFinger?.iconImage?.withRenderingMode(
                        .alwaysOriginal), for: [])
                    btn.setBackgroundImage(UIImage(named: "color_\(follower?.items?.leftFinger?.displayColor ?? "")"), for: [])
                    setEquipButtonGems(index: index, btn: btn, item: follower?.items?.leftFinger)
                // right ring
                case 204:
                    btn.setImage(follower?.items?.rightFinger?
                        .iconImage?.withRenderingMode(
                        .alwaysOriginal), for: [])
                    btn.setBackgroundImage(UIImage(named: "color_\(follower?.items?.rightFinger?.displayColor ?? "")"), for: [])
                    setEquipButtonGems(index: index, btn: btn, item: follower?.items?.rightFinger)
                // neck
                case 205:
                    btn.setImage(follower?.items?.neck?.iconImage?.withRenderingMode(
                        .alwaysOriginal), for: [])
                    btn.setBackgroundImage(UIImage(named: "color_\(follower?.items?.neck?.displayColor ?? "")"), for: [])
                    setEquipButtonGems(index: index, btn: btn, item: follower?.items?.neck)
                // special
                case 206:
                    btn.setImage(follower?.items?.special?.iconImage?.withRenderingMode(
                        .alwaysOriginal), for: [])
                    btn.setBackgroundImage(UIImage(named: "color_\(follower?.items?.special?.displayColor ?? "")"), for: [])
                    specialBorderImageView.isHidden = follower?.items?.special == nil
                    setEquipButtonGems(index: index, btn: btn, item: follower?.items?.special)
                default:
                    break
                }
            }
        }
    }
    
    @IBOutlet var specialBorderImageView: UIImageView!
    @IBOutlet var skillNameLabels: [UILabel]!
    @IBOutlet var skillButtons: [UIButton]!
    @IBOutlet var equipButtons: [UIButton]!
    @IBOutlet var valueLabels: [UILabel]!
    
    func resetSkillButtonImages(){
        for btn in skillButtons{
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
    }
    
    @IBAction func clickSkillButton(_ sender: UIButton){
        delegate?.didClickSkillButton(view: self, index: sender.tag)
    }
    @IBAction func clickEquipButton(_ sender: UIButton){
        delegate?.didClickEquipButton(view: self, index: sender.tag)
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

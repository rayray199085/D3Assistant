//
//  SCPassiveSkillSelectionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 21/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

private let maximumSelectedSkillCount: Int = 4
protocol SCPassiveSkillSelectionViewDelegate: NSObjectProtocol{
    func hasReachedMaxSelectedSkillCount(view: SCPassiveSkillSelectionView)
    func didClickPassiveSkillItem(view: SCPassiveSkillSelectionView, index: Int)
}

class SCPassiveSkillSelectionView: UIView {
    var hasSelectedSkillCount: Int = 0
    weak var delegate: SCPassiveSkillSelectionViewDelegate?
    
    var passiveSkills: [SCPassiveSkill]?{
        didSet{
            setupSkillSelectionView()
        }
    }
    func setupSkillSelectionView(){
        guard let passiveSkills = passiveSkills else{
            return
        }
        let width: CGFloat = 50
        let horizontalMargin: CGFloat = 5
        let verticalMargin: CGFloat = 5
//        let itemCount = CGFloat(passiveSkills.count)
        let leftMargin: CGFloat = (bounds.width - width * 5 - horizontalMargin * 4) / 2
        let topMargin: CGFloat = (bounds.height - width * 4 - verticalMargin * 3) / 2
        for (index,skill) in passiveSkills.enumerated(){
            let skillItem = SCPassiveSkillItemView.skillItemView()
            skillItem.passiveSkillButton.tag = index
            var x = leftMargin + width * CGFloat(index % 5)
            x += (index % 5) > 0 ? horizontalMargin * CGFloat(index % 5) : 0
            var y = topMargin + width * CGFloat(index / 5)
            y += (index / 5) > 0 ? verticalMargin * CGFloat(index / 5) : 0
            skillItem.frame = CGRect(x: x, y: y, width: width, height: width)
            skillItem.passiveSkillButton.setImage(skill.skillImage, for: [])
            skillItem.passiveSkillButton.tag = index
            skillItem.delegate = self
            addSubview(skillItem)
        }
    }
    func clearAllSelectedSkills(){
        for v in subviews as! [SCPassiveSkillItemView]{
            v.cancelSelectedItem()
        }
    }
    
    func selectedSkillRequiredLevel()->Int{
        var maxLevel: Int = 1
        for (index,v) in subviews.enumerated(){
            if (v as! SCPassiveSkillItemView).isSelected(){
                maxLevel = max(maxLevel, passiveSkills?[index].level ?? 1)
            }
        }
        return maxLevel
    }
}
extension SCPassiveSkillSelectionView: SCPassiveSkillItemViewDelegate{
    func didClickPassiveSkillButton(view: SCPassiveSkillItemView, index: Int) {
        delegate?.didClickPassiveSkillItem(view: self, index: index)
        if hasSelectedSkillCount == maximumSelectedSkillCount - 1{
            delegate?.hasReachedMaxSelectedSkillCount(view: self)
        }else{
            hasSelectedSkillCount += 1
        }
    }
}

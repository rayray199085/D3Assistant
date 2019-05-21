//
//  SCActiveSkillSelectionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 20/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCActiveSkillSelectionViewDelegate: NSObjectProtocol {
    func didSelectedActiveSkillItem(view: SCActiveSkillSelectionView,tag: Int)
}
class SCActiveSkillSelectionView: UIView {
//    weak var parentView: SCActiveSkillsIntroView?
    weak var delegate : SCActiveSkillSelectionViewDelegate?
    
    func setupSkillView(index: Int,categorySkills: [[SCActiveSkill]]?){
        // clear all previous subview
        clearActiveSkillViewSubViews()
        guard let selectedCategorySkills = categorySkills?[index] else{
            return
        }
        let width: CGFloat = 50
        let horizontalMargin: CGFloat = 5
        let itemCount = CGFloat(selectedCategorySkills.count)
        let leftMargin: CGFloat = (bounds.width - width * itemCount - horizontalMargin * (itemCount - 1)) / 2
        let y = (bounds.height - width) / 2
        for (index,skill) in selectedCategorySkills.enumerated(){
            let skillItem = SCActiveSkillItemView.skillItemView()
            skillItem.skillButton.tag = index
            skillItem.delegate = self
            var x = leftMargin + width * CGFloat(index)
            x += index > 0 ? horizontalMargin * CGFloat(index) : 0
            skillItem.frame = CGRect(x: x, y: y, width: width, height: width)
            skillItem.skillButton.setImage(skill.skillImage, for: [])
            addSubview(skillItem)
        }
    }
    
    /// This method will be called when showing introView
    private func clearActiveSkillViewSubViews(){
        for v in subviews{
            v.removeFromSuperview()
        }
    }
}
extension SCActiveSkillSelectionView: SCActiveSkillItemViewDelegate{
    ///
    /// - Parameters:
    ///   - view: SCActiveSkillItemView
    ///   - tag: the index of skill view button
    func didClickSkillButton(view: SCActiveSkillItemView, tag: Int) {
        //      clear all selected button
        for skillItem in subviews as! [SCActiveSkillItemView]{
            skillItem.cancelSelection()
        }
        (subviews[tag] as! SCActiveSkillItemView).didSelected()
        delegate?.didSelectedActiveSkillItem(view: self,tag: tag)
    }
}

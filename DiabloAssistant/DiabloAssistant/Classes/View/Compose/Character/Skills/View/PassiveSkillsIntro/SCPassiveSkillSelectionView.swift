//
//  SCPassiveSkillSelectionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 21/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCPassiveSkillSelectionView: UIView {
    var viewModel: SCCharacterViewModel?{
        didSet{
            setupSkillSelectionView()
        }
    }
    func setupSkillSelectionView(){
        
        guard let passiveSkills = viewModel?.character?.skills?.passive else{
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
//            skillItem.passiveSkillButton.setImage(skill.skillImage, for: [])
            addSubview(skillItem)
        }
    }
}

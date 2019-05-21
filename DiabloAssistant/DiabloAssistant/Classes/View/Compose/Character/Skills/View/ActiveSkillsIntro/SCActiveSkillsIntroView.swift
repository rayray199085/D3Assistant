//
//  SCActiveSkillsIntroView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 19/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import Atributika

protocol SCActiveSkillsIntroViewDelegate: NSObjectProtocol {
    
    /// for three button closing introView
    ///
    /// - Parameters:
    ///   - view: introView
    ///   - tag: close btn tag: 0, yes btn tag: 1, no btn tag: 2
    func clickQuitButton(view: SCActiveSkillsIntroView, tag: Int)
    func getSelectedSkillAndRune(typeIndex: Int, skillIndex: Int, runeIndex: Int, requiredLevel: Int)
}
class SCActiveSkillsIntroView: UIView {
    
    /// record selected activeSkill info
    private var activeSkillDescription: NSAttributedString?
    private var activeSkillIndex: Int = 0
    private var selectedRuneIndex: Int = 0
    private var requiredLevel: Int = 1
    private var character: SCCharacter?
    private var categorySkills: [[SCActiveSkill]]?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skillView: SCActiveSkillSelectionView!
    @IBOutlet weak var runeView: SCRuneSelectionView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    weak var delegate: SCActiveSkillsIntroViewDelegate?
    
    /// According to the button tag to descide introView's title
    var index: Int = 0{
        didSet{
            skillView.setupSkillView(index: index,categorySkills: categorySkills)
            titleLabel.text = character?.skillCategories?[index].slug
            pageControl.numberOfPages = character?.skillCategories?.count ?? 0
            pageControl.currentPage = index
        }
    }
    var viewModel: SCCharacterViewModel?{
        didSet{
            character = viewModel?.character
            categorySkills = viewModel?.categorySkills
        }
    }
    
    class func skillIntroView()->SCActiveSkillsIntroView{
        let nib = UINib(nibName: "SCActiveSkillsIntroView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCActiveSkillsIntroView
        v.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
        return v
    }
    
    override func awakeFromNib() {
        skillView.delegate = self
        runeView.delegate = self 
    }
    
    @IBAction func clickChangePageButton(_ sender: UIButton) {
        switch sender.tag {
        // left button tag: 101
        case 101:
            index -= index == 0 ? -5 : 1
        // right button tag: 102
        case 102:
            index += index == 5 ? -5 : 1
        default:
            break
        }
        titleLabel.text = character?.skillCategories?[index].slug
        resetIntroView()
    }
    
    @IBAction func clickButtonToDismissIntroView(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            delegate?.getSelectedSkillAndRune(
                typeIndex: index,
                skillIndex: activeSkillIndex,
                runeIndex: selectedRuneIndex,
                requiredLevel: requiredLevel)
        default:
            break
        }
        delegate?.clickQuitButton(view: self, tag: sender.tag)
    }
}

// MARK: - clear previous record and reset UI
extension SCActiveSkillsIntroView{
    
    /// to next or to prev page of skills
    func resetIntroView(){
        runeView.clearRuneViewSubviews()
        resetTemporaryRecords()
    }
    
    private func resetTemporaryRecords(){
        requiredLevel = 1
        selectedRuneIndex = 0
        activeSkillIndex = 0
        activeSkillDescription = NSAttributedString(string: "")
        textView.attributedText = NSAttributedString(string: "")
    }
}

extension SCActiveSkillsIntroView: SCActiveSkillSelectionViewDelegate{
    func didSelectedActiveSkillItem(view: SCActiveSkillSelectionView,tag: Int) {
        let selectedSkill = categorySkills?[index][tag]
        requiredLevel = selectedSkill?.level ?? 1
        activeSkillIndex = tag
        
        runeView.setupRuneView(runes: categorySkills?[index][activeSkillIndex].runes)
        
        activeSkillDescription = NSAttributedString.getDescriptionAttributedText(
            skillName: selectedSkill?.name,
            skillLevel: selectedSkill?.level ?? 1,
            htmlString: selectedSkill?.descriptionHtml)
        
        runeView.didClickRune(view: runeView.subviews[0] as! SCActiveSkillRuneView, tag: 0)
    }
}
extension SCActiveSkillsIntroView: SCRuneSelectionViewDelegate{
    func didSelectedRuneItem(view: SCRuneSelectionView, tag: Int) {
        guard let rune = categorySkills?[index][activeSkillIndex].runes?[tag] else{
            return
        }
        selectedRuneIndex = tag
        requiredLevel = max(requiredLevel, rune.level)
        let runeDescription = NSAttributedString.getDescriptionAttributedText(
            skillName: rune.name,
            skillLevel: rune.level,
            htmlString: rune.descriptionHtml)
        
        /// put activeSkill descrpition + rune description into textView
        let attrString = NSMutableAttributedString(attributedString: activeSkillDescription ?? NSAttributedString(string: ""))
        attrString.append(NSAttributedString(string: "\n\n"))
        attrString.append(runeDescription)
        textView.attributedText = attrString
    }
}

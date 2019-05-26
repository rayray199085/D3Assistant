//
//  SCPassiveSkillsIntroView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 21/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCPassiveSkillsIntroViewDelegate: NSObjectProtocol {
    func clickQuitButton(view: SCPassiveSkillsIntroView)
    func didClickPassiveSkillItem(view: SCPassiveSkillsIntroView, index: Int)
}
class SCPassiveSkillsIntroView: UIView {
    weak var delegate: SCPassiveSkillsIntroViewDelegate?
    
    var passiveSkillRequiredLevel: Int{
        return passiveSkillView.selectedSkillRequiredLevel()
    }
    
    var passiveSkills: [SCPassiveSkill]?{
        didSet{
            passiveSkillView.passiveSkills = passiveSkills
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var passiveSkillView: SCPassiveSkillSelectionView!
    @IBOutlet weak var textView: UITextView!
    @IBAction func clickCloseButton(_ sender: Any) {
        delegate?.clickQuitButton(view: self)
    }
    
    class func skillIntroView()->SCPassiveSkillsIntroView{
        let nib = UINib(nibName: "SCPassiveSkillsIntroView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCPassiveSkillsIntroView
        v.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
        return v
    }
    override func awakeFromNib() {
        passiveSkillView.delegate = self
    }
    func resetPassiveSKillView(){
        passiveSkillView.clearAllSelectedSkills()
        passiveSkillView.hasSelectedSkillCount = 0
        textView.attributedText = NSAttributedString(string: "")
    }
    
    func cancelPreviousSelection(index: Int){
         passiveSkillView.hasSelectedSkillCount -= 1
        (passiveSkillView.subviews[index] as! SCPassiveSkillItemView).cancelSelectedItem()
    }
    
    private func setSkillDescription(){
        textView.attributedText = NSAttributedString(string: "")
        let attrStringM = NSMutableAttributedString(string: "")
        for (index,v) in passiveSkillView.subviews.enumerated(){
            if (v as! SCPassiveSkillItemView).isSelected(){
                attrStringM.append(
                    NSAttributedString.getSkillDescriptionAttributedText(skillName: passiveSkills?[index].name, skillLevel: passiveSkills?[index].level ?? 1, htmlString: passiveSkills?[index].descriptionHtml))
                attrStringM.append(NSAttributedString(string: "\n\n"))
            }
        }
        textView.attributedText = attrStringM
    }
}
extension SCPassiveSkillsIntroView: SCPassiveSkillSelectionViewDelegate{
    func hasReachedMaxSelectedSkillCount(view: SCPassiveSkillSelectionView) {
        delegate?.clickQuitButton(view: self)
    }
    func didClickPassiveSkillItem(view: SCPassiveSkillSelectionView, index: Int) {
        delegate?.didClickPassiveSkillItem(view: self, index: index)
        setSkillDescription()
    }
}


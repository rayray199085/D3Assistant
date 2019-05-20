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
}
class SCActiveSkillsIntroView: UIView {
    var index: Int = 0{
        didSet{
            setupSkillView(index: index)
            titleLabel.text = character?.skillCategories?[index].slug
            pageControl.numberOfPages = character?.skillCategories?.count ?? 0
            pageControl.currentPage = index
        }
    }
    var character: SCCharacter?{
        didSet{
            guard let characterName = character?.slug,
                  let skillArray = character?.skills?.active else{
                return
            }
            
            var skillTypeArray: [Int]?
            for dict in SCActiveSkillsDictionaryArray {
                if characterName == dict["name"] as! String{
                    skillTypeArray = (dict["activeSkills"] as! [Int])
                    break
                }
            }
            var location = 0
            categorySkills = [[SCActiveSkill]]()
            for count in skillTypeArray ?? []{
                let subArray = (skillArray as NSArray).subarray(with: NSRange(location: location, length: count)) as! [SCActiveSkill]
                categorySkills?.append(subArray)
                location += count
            }
        }
    }
    private var categorySkills: [[SCActiveSkill]]?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skillView: UIView!
    @IBOutlet weak var runeView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    weak var delegate: SCActiveSkillsIntroViewDelegate?
    
    class func skillIntroView()->SCActiveSkillsIntroView{
        let nib = UINib(nibName: "SCActiveSkillsIntroView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCActiveSkillsIntroView
        v.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
        return v
    }
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func clickRightButton(_ sender: Any) {
        index += index == 5 ? -5 : 1
        titleLabel.text = character?.skillCategories?[index].slug
        clearRuneViewSubviews()
        clearTextViewContent()
    }
    
    @IBAction func clickLeftButton(_ sender: Any) {
        index -= index == 0 ? -5 : 1
        titleLabel.text = character?.skillCategories?[index].slug
        clearRuneViewSubviews()
        clearTextViewContent()
    }
    
    @IBAction func clickYesButton(_ button: UIButton) {
        delegate?.clickQuitButton(view: self, tag: 1)
    }
    
    @IBAction func clickNoButton(_ button: UIButton) {
        delegate?.clickQuitButton(view: self, tag: 2)
    }
    
    @IBAction func clickCloseButton(_ button: UIButton) {
        delegate?.clickQuitButton(view: self, tag: 0)
    }
}
private extension SCActiveSkillsIntroView{

    func setupSkillView(index: Int){
        // clear all previous subview
        clearActiveSkillViewSubViews()
        guard let selectedCategorySkills = categorySkills?[index] else{
            return
        }
        let width: CGFloat = 50
        let horizontalMargin: CGFloat = 5
        let itemCount = CGFloat(selectedCategorySkills.count)
        let leftMargin: CGFloat = (skillView.bounds.width - width * itemCount - horizontalMargin * (itemCount - 1)) / 2
        let y = (skillView.bounds.height - width) / 2
        for (index,skill) in selectedCategorySkills.enumerated(){
            let skillItem = SCActiveSkillItemView.skillItemView()
            skillItem.skillButton.tag = index
            skillItem.delegate = self
            var x = leftMargin + width * CGFloat(index)
            x += index > 0 ? horizontalMargin * CGFloat(index) : 0
            skillItem.frame = CGRect(x: x, y: y, width: width, height: width)
            skillItem.skillButton.setImage(skill.skillImage, for: [])
            skillView.addSubview(skillItem)
        }
    }
    func setupRuneView(index: Int){
        // clear all previous subView
        clearRuneViewSubviews()
        guard let runes = character?.skills?.active?[index].runes else{
            return
        }
        let width: CGFloat = 40
        let horizontalMargin: CGFloat = 5
        let itemCount = CGFloat(runes.count)
        let leftMargin = (runeView.bounds.width - width * itemCount - horizontalMargin * (itemCount - 1)) / 2
        let y = (runeView.bounds.height - width) / 2
        for (index,rune) in runes.enumerated(){
            let runeItem = SCActiveSkillRuneView.runeView()
            var x = leftMargin + width * CGFloat(index)
            x += index > 0 ? horizontalMargin * CGFloat(index) : 0
            runeItem.frame = CGRect(x: x, y: y, width: width, height: width)
            
            runeItem.runeButton.setBackgroundImage(UIImage(named: "rune\(rune.type?.uppercased() ?? "")"), for: [])
            runeItem.runeButton.tag = index
            runeItem.delegate = self
            runeView.addSubview(runeItem)
        }
    }
    func clearRuneViewSubviews(){
        for v in runeView.subviews{
            v.removeFromSuperview()
        }
    }
    
    func clearActiveSkillViewSubViews(){
        for v in skillView.subviews{
            v.removeFromSuperview()
        }
    }
}
extension SCActiveSkillsIntroView: SCActiveSkillItemViewDelegate{
    func didClickSkillButton(view: SCActiveSkillItemView, tag: Int) {
//      clear all selected button
        for skillItem in skillView.subviews as! [SCActiveSkillItemView]{
            skillItem.cancelSelection()
        }
        (skillView.subviews[tag] as! SCActiveSkillItemView).didSelected()
        setupRuneView(index: tag)

        let selectedSkill = categorySkills?[index][tag]
        textView.attributedText = getDescriptionAttributedText(
            skillName: selectedSkill?.name,
            skillLevel: selectedSkill?.level ?? 1,
            htmlString: selectedSkill?.descriptionHtml)
    }
}

extension SCActiveSkillsIntroView: SCActiveSkillRuneViewDelegate{
    func didClickRune(view: SCActiveSkillRuneView, tag: Int) {
//        clear all selected button
        for runeItem in runeView.subviews as! [SCActiveSkillRuneView]{
            runeItem.cancelSelection()
        }
        (runeView.subviews[tag] as! SCActiveSkillRuneView).didSelected()
    }
}

private extension SCActiveSkillsIntroView{
    func getDescriptionAttributedText(skillName: String?, skillLevel: Int, htmlString: String?) -> NSAttributedString {
        let skillDescription = NSMutableAttributedString(string: "\(skillName ?? "")\n")
        skillDescription.addAttributes(
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
             NSAttributedString.Key.foregroundColor: SCButtonTitleColor], range: NSRange(location: 0, length: skillDescription.length))
        
        let des = htmlString ?? ""
        let digits = Style("span").font(.boldSystemFont(ofSize: 13)).foregroundColor(.green)
        let all = Style.font(.systemFont(ofSize: 13)).foregroundColor(SCButtonTitleColor)
        skillDescription.append(des.style(tags: [digits]).styleAll(all).attributedString)
        
        let requiredLevel = NSMutableAttributedString(string: "\nRequired level: \(skillLevel)")
        requiredLevel.addAttributes(
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13),
             NSAttributedString.Key.foregroundColor: UIColor.purple], range: NSRange(location: 0, length: requiredLevel.length))
        skillDescription.append(requiredLevel)
        return skillDescription
    }
    
    func clearTextViewContent(){
        textView.attributedText = NSAttributedString(string: "")
    }
}

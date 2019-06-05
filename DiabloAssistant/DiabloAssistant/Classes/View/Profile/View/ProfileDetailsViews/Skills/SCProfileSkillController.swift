//
//  SCProfileSkillController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCProfileSkillController: UIViewController {
    var hasLoadImages: Bool = false
    
    var viewModel: SCProfileViewModel?{
        didSet{
            if hasLoadImages{
                return 
            }
            SVProgressHUD.show()
            viewModel?.loadSkillimages(completion: { [weak self] (isSuccess) in
                if !isSuccess{
                    return
                }
                guard let activeSkills = self?.viewModel?.heroSkills?.active,
                      let passiveSkills = self?.viewModel?.heroSkills?.passive else{
                    return
                }
                for (index,skill) in activeSkills.enumerated(){
                    (self?.activeSkillView.subviews[index] as! SCProfileActiveSkillView).activeSkill = skill
                }
                for (index, skill) in passiveSkills.enumerated(){
                    (self?.passiveSkillView.subviews[index] as! SCProfilePassiveSkillView).passiveSkill = skill
                }
                SVProgressHUD.dismiss()
                self?.hasLoadImages = true
            })

        }
    }
    @IBOutlet weak var passiveSkillView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activeSkillView: UIView!
    @IBOutlet weak var runeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    deinit {
        hasLoadImages = false
    }
}
private extension SCProfileSkillController{
    func setupUI(){
        setupActiveSkillView()
        setupPassiveSkillView()
    }
    func setupActiveSkillView(){
        let margin: CGFloat = 5
        let width: CGFloat = 170
        let height: CGFloat = 45
        let horizontalMargin = (UIScreen.screenWidth() - width * 2 - margin) / 2
        let verticalMargin = (activeSkillView.bounds.height - height * 3) / 4
        for i in 0..<6{
            let x = horizontalMargin +  CGFloat(i % 2) * (width + margin)
            let y = verticalMargin + CGFloat(i / 2) * (height + verticalMargin)
            let v = SCProfileActiveSkillView.skillView(index: i)
            v.frame = CGRect(x: x, y: y, width: width, height: height)
            v.tag = i
            v.delegate = self
            activeSkillView.addSubview(v)
        }
    }
    func setupPassiveSkillView(){
        let width: CGFloat = 60
        let margin = (UIScreen.screenWidth() - width * 4) / 5
        for i in 0..<4{
            let x = margin + CGFloat(i % 4) * (width + margin)
            let v = SCProfilePassiveSkillView.skillView()
            v.frame = CGRect(x: x, y: 0, width: width, height: width)
            v.tag = i
            v.delegate = self
            passiveSkillView.addSubview(v)
        }
        
    }
}
extension SCProfileSkillController: SCProfileActiveSkillViewDelegate{
    func didClickActiveSkillButton(view: SCProfileActiveSkillView, index: Int) {
        guard let skill = viewModel?.heroSkills?.active?[index].skill else{
            return
        }
       
        let attrText = NSMutableAttributedString(string: "")
        attrText.append(NSAttributedString.getSkillDescriptionAttributedText(skillName: skill.name, skillLevel: skill.level, htmlString: skill.descriptionHtml))
        textView.attributedText = attrText
        guard let rune = viewModel?.heroSkills?.active?[index].rune else{
            runeImageView.image = nil
            return
        }
        runeImageView.image = UIImage(named: "rune\(rune.type?.uppercased() ?? "")")
        attrText.append(NSAttributedString(string: "\n\n"))
        attrText.append(NSAttributedString.getSkillDescriptionAttributedText(skillName: rune.name, skillLevel: rune.level, htmlString: rune.descriptionHtml))
        textView.attributedText = attrText
        
    }
}
extension SCProfileSkillController: SCProfilePassiveSkillViewDelegate{
    func didClickPassiveSkillButton(view: SCProfilePassiveSkillView, index: Int) {
        guard let skill = viewModel?.heroSkills?.passive?[index] else{
            return
        }
        runeImageView.image = nil
        let attrText = NSMutableAttributedString(string: "")
        attrText.append(NSAttributedString.getSkillDescriptionAttributedText(skillName: skill.skill?.name, skillLevel: skill.skill?.level ?? 0, htmlString: skill.skill?.descriptionHtml))
        textView.attributedText = attrText
    }
}

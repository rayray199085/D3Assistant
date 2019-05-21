//
//  SCSkillsViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 18/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD


private let activeSkillCount: Int = 6
private let passiveSkillCount: Int = 4
class SCSkillsViewController: UIViewController {
    
    @IBOutlet weak var requiredLevelLabel: UILabel!
    @IBOutlet weak var activeSkillView: UIView!
    @IBOutlet weak var passiveSkillView: UIView!
    var characterViewModel: SCCharacterViewModel?
    private lazy var activeSkillIntroView: SCActiveSkillsIntroView = SCActiveSkillsIntroView.skillIntroView()
    private lazy var maskView = UIView(frame: UIScreen.main.bounds)
    private var selectedButtonIndex: Int = 0
    private lazy var selectedActiveSkills = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
        characterViewModel?.loadCharacter(completion: {[weak self] (isSuccess) in
            guard let character = self?.characterViewModel?.character else{
                return
            }
            self?.activeSkillIntroView.viewModel = self?.characterViewModel
            
            for (index,skillView) in (self?.activeSkillView.subviews.enumerated())!{
                (skillView as! SCActiveSkillView).titleLabel.text = character.skillCategories?[index].name
            }
            SVProgressHUD.dismiss()
        })
    }
    
    @objc private func clickActiveSkillButton(button: UIButton){
        displayActiveIntroView()
        activeSkillIntroView.index = button.tag
        selectedButtonIndex = button.tag
    }
    
    
    /// clear all selected record
    ///
    /// - Parameter sender: reset button
    @IBAction func clickResetButton(_ sender: Any) {
        requiredLevelLabel.text = "\(0)"
        selectedActiveSkills.removeAll()
        for (index,v) in activeSkillView.subviews.enumerated(){
            (v as! SCActiveSkillView).resetActiveSkillView(title: characterViewModel?.character?.skillCategories?[index].name)
        }
    }
    
    deinit {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
    }
}

// MARK: - setup UI
private extension SCSkillsViewController{
    func setupUI(){
        setupActiveSkillView()
        setupPassiveSkillView()
        setupActiveSkillIntroView()
    }
    
    /// setupActivdSkillView
    func setupActiveSkillView(){
        let width: CGFloat = 180
        let height: CGFloat = 84
        let horizontalMargin = (UIScreen.screenWidth() - width * 2) / 3
        let verticalMargin = (activeSkillView.bounds.height - 3 * height) / 4
        for index in 0..<activeSkillCount{
            let v = SCActiveSkillView.activeSkillView()
            let x = CGFloat(index % 2) * (horizontalMargin + width) + horizontalMargin
            let y = CGFloat(index / 2) * (verticalMargin + height) + verticalMargin
            v.frame = CGRect(x: x, y: y, width: width, height: height)
            v.skillOptionButton.tag = index
            v.skillOptionButton.addTarget(self, action: #selector(clickActiveSkillButton), for: UIControl.Event.touchUpInside)
            activeSkillView.addSubview(v)
        }
        
        for index in 0..<activeSkillCount{
            let activeView = activeSkillView.subviews[index] as! SCActiveSkillView
            activeView.controlImageView.image = UIImage(named: "position_\(index)")
        }
    }
    
    /// setup passiveSkillView
    func setupPassiveSkillView(){
        let width: CGFloat = 80
        let horizontalMargin = (UIScreen.screenWidth() - width * 4) / 5
        for index in 0..<passiveSkillCount{
            let v = SCPassiveSkillView.passiveSkillView()
            let x = CGFloat(index % 4) * (horizontalMargin + width) + horizontalMargin
            let y = (passiveSkillView.bounds.height - width) / 2
            v.frame = CGRect(x: x, y: y, width: width, height: width)
            passiveSkillView.addSubview(v)
        }
    }
    
    /// setup activeSkillIntroView and maskView
    func setupActiveSkillIntroView(){
        guard let naviView = navigationController?.view else{
            return
        }
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.8
        activeSkillIntroView.center = naviView.center
        activeSkillIntroView.delegate = self
        hideActiveIntroView()
        naviView.addSubview(maskView)
        naviView.addSubview(activeSkillIntroView)
    }
    
    func displayActiveIntroView(){
        maskView.isHidden = false
        activeSkillIntroView.isHidden = false
    }
    func hideActiveIntroView(){
        maskView.isHidden = true
        activeSkillIntroView.isHidden = true
    }
}

extension SCSkillsViewController: SCActiveSkillsIntroViewDelegate{
    func clickQuitButton(view: SCActiveSkillsIntroView, tag: Int) {
        hideActiveIntroView()
        activeSkillIntroView.resetIntroView()
    }
    func getSelectedSkillAndRune(typeIndex: Int, skillIndex: Int, runeIndex: Int, requiredLevel: Int) {
    
        guard let categerySkills = characterViewModel?.categorySkills,
              let type = categerySkills[typeIndex][skillIndex].runes?[runeIndex].type?.uppercased() else {
            return
        }
        let activeSkill = categerySkills[typeIndex][skillIndex]
        
        // check whether skill was selected before
        deleteSkillFromSelectedArray(previousSkillName: activeSkill.name)
        
        // check whether the selected button has been used
        let v = activeSkillView.subviews[selectedButtonIndex] as! SCActiveSkillView
        if v.skillNameLabel.text != "Choose Skill"{
            deleteSkillFromSelectedArray(previousSkillName: v.skillNameLabel.text)
        }
        
        v.setActiveSkillView(
            skillIcon: activeSkill.skillImage,
            skillName: activeSkill.name,
            runeImage: UIImage(named: "typeSmall\(type)"),
            runeName: activeSkill.runes?[runeIndex].name,
            title: activeSkill.type?.capitalizingFirstLetter())
        
        let dict = ["skillName": activeSkill.name ?? "", "buttonIndex": selectedButtonIndex, "requiredLevel": requiredLevel] as [String : Any]
        selectedActiveSkills.append(dict)
        
        // calculate required level
        var largestRequredLevel: Int = 0
        for dict in selectedActiveSkills{
            guard let level = dict["requiredLevel"] as? Int else{
                continue
            }
            largestRequredLevel = max(level, largestRequredLevel)
        }
        requiredLevelLabel.text = "\(largestRequredLevel)"
    }
}
private extension SCSkillsViewController{
    
    /// delete previous selected skill from selected skill array
    ///
    /// - Parameter previousSkillName: previous SkillName
    func deleteSkillFromSelectedArray(previousSkillName: String?){
        for (index,dict) in selectedActiveSkills.enumerated(){
            guard let categories = characterViewModel?.character?.skillCategories,
                let name = dict["skillName"] as? String,
                let position = dict["buttonIndex"] as? Int else{
                    continue
            }
            if name == previousSkillName{
                selectedActiveSkills.remove(at: index)
                (activeSkillView.subviews[position] as! SCActiveSkillView).resetActiveSkillView(title: categories[position].name)
                break
            }
        }
    }
}

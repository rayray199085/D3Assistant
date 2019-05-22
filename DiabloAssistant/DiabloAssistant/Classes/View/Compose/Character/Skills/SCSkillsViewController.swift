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
private let passiveSkillRequiredLevel = [10, 20, 30, 70]
class SCSkillsViewController: UIViewController {
    
    @IBOutlet weak var requiredLevelLabel: UILabel!
    @IBOutlet weak var activeSkillView: UIView!
    @IBOutlet weak var passiveSkillView: UIView!
    var characterViewModel: SCCharacterViewModel?
    private lazy var activeSkillIntroView: SCActiveSkillsIntroView = SCActiveSkillsIntroView.skillIntroView()
    private lazy var passiveSkillIntroView: SCPassiveSkillsIntroView = SCPassiveSkillsIntroView.skillIntroView()
    private lazy var maskView = UIView(frame: UIScreen.main.bounds)
    private var selectedActiveSkillButtonIndex: Int = 0
    private lazy var selectedActiveSkills = [[String: Any]]()
    private var currentSelectedPassiveButtonIndex: Int = 0
    private var maxPassiveSkillLevel: Int = 1
    private var maxActiveSkillLevel: Int = 1
    
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
            self?.passiveSkillIntroView.passiveSkills = self?.characterViewModel?.character?.skills?.passive
            
            for (index,skillView) in (self?.activeSkillView.subviews.enumerated())!{
                (skillView as! SCActiveSkillView).titleLabel.text = character.skillCategories?[index].name
            }
            SVProgressHUD.dismiss()
        })
    }
    
    @objc private func clickActiveSkillButton(button: UIButton){
        displayActiveIntroView()
        activeSkillIntroView.index = button.tag
        selectedActiveSkillButtonIndex = button.tag
    }
    
    
    /// clear all selected record
    ///
    /// - Parameter sender: reset button
    @IBAction func clickResetButton(_ sender: Any) {
        requiredLevelLabel.text = "\(1)"
        selectedActiveSkills.removeAll()
        for (index,v) in activeSkillView.subviews.enumerated(){
            (v as! SCActiveSkillView).resetActiveSkillView(title: characterViewModel?.character?.skillCategories?[index].name)
        }
        currentSelectedPassiveButtonIndex = 0
        passiveSkillIntroView.resetPassiveSKillView()
        for v in passiveSkillView.subviews{
            (v as! SCPassiveSkillView).resetSkillView()
        }
        maxPassiveSkillLevel = 1
        maxActiveSkillLevel = 1
    }
    
    deinit {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
    }
    
    @objc private func clickPassiveFrameButton(button: UIButton){
        currentSelectedPassiveButtonIndex = button.tag
        let v = passiveSkillView.subviews[button.tag] as! SCPassiveSkillView
        v.didSelected()
        displayPassiveIntroView()
    }
}

// MARK: - setup UI
private extension SCSkillsViewController{
    func setupUI(){
        setupActiveSkillView()
        setupPassiveSkillView()
        setupActiveSkillIntroView()
        setupPassiveSkillIntroView()
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
            v.passiveFrameButton.addTarget(self, action: #selector(clickPassiveFrameButton), for: UIControl.Event.touchUpInside)
            v.passiveFrameButton.tag = index
            v.setLevel(level: passiveSkillRequiredLevel[index])
            passiveSkillView.addSubview(v)
        }
    }
    
    /// setup activeSkillIntroView and maskView
    func setupActiveSkillIntroView(){
        guard let naviView = navigationController?.view else{
            return
        }
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.3
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
    
    func setupPassiveSkillIntroView(){
        guard let naviView = navigationController?.view else{
            return
        }
        passiveSkillIntroView.center = naviView.center
        passiveSkillIntroView.delegate = self
        hidePassiveIntroView()
        naviView.addSubview(passiveSkillIntroView)
    }
    func displayPassiveIntroView(){
        maskView.isHidden = false
        passiveSkillIntroView.isHidden = false
    }
    func hidePassiveIntroView(){
        maskView.isHidden = true
        passiveSkillIntroView.isHidden = true
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
        let v = activeSkillView.subviews[selectedActiveSkillButtonIndex] as! SCActiveSkillView
        if v.skillNameLabel.text != "Choose Skill"{
            deleteSkillFromSelectedArray(previousSkillName: v.skillNameLabel.text)
        }
        
        v.setActiveSkillView(
            skillIcon: activeSkill.skillImage,
            skillName: activeSkill.name,
            runeImage: UIImage(named: "typeSmall\(type)"),
            runeName: activeSkill.runes?[runeIndex].name,
            title: activeSkill.type?.capitalizingFirstLetter())
        
        let dict = ["skillName": activeSkill.name ?? "", "buttonIndex": selectedActiveSkillButtonIndex, "requiredLevel": requiredLevel] as [String : Any]
        selectedActiveSkills.append(dict)
        
        // calculate required level
        var largestRequredLevel: Int = 0
        for dict in selectedActiveSkills{
            guard let level = dict["requiredLevel"] as? Int else{
                continue
            }
            largestRequredLevel = max(level, largestRequredLevel)
        }
        maxActiveSkillLevel = largestRequredLevel
        requiredLevelLabel.text = "\(max(maxActiveSkillLevel, maxPassiveSkillLevel))"
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

extension SCSkillsViewController: SCPassiveSkillsIntroViewDelegate{
    func clickQuitButton(view: SCPassiveSkillsIntroView) {
        hidePassiveIntroView()
        for v in passiveSkillView.subviews{
            (v as! SCPassiveSkillView).cancelSelection()
        }
    }
    func didClickPassiveSkillItem(view: SCPassiveSkillsIntroView, index: Int) {
        let skill = characterViewModel?.character?.skills?.passive?[index]
        let v = passiveSkillView.subviews[currentSelectedPassiveButtonIndex] as! SCPassiveSkillView
        // if v has image, remove its selection
        if v.passiveSkillImageView.image != nil{
            passiveSkillIntroView.cancelPreviousSelection(index: v.passiveSkillIndex)
        }
        v.passiveSkillIndex = index
        v.passiveSkillImageView.image = skill?.skillImage
        
        var maxLevel = 0
        for (index,v) in passiveSkillView.subviews.enumerated(){
            if (v as! SCPassiveSkillView).isSelected(){
                maxLevel =  max(maxLevel, passiveSkillRequiredLevel[index])
            }
        }
        maxPassiveSkillLevel = max(maxLevel, passiveSkillIntroView.passiveSkillRequiredLevel)
        requiredLevelLabel.text = "\(max(maxActiveSkillLevel, maxPassiveSkillLevel))"
        
        let position = searchNextEmptyPosition()
        if position == -1{
            v.cancelSelection()
            return
        }
        currentSelectedPassiveButtonIndex = position
        let nextV = passiveSkillView.subviews[currentSelectedPassiveButtonIndex] as! SCPassiveSkillView
        if !nextV.isSelected(){
            nextV.didSelected()
            v.cancelSelection()
        }
    }
}
extension SCSkillsViewController{
    
    /// Search empty passive skill button
    ///
    /// - Returns: if empty position exists return position index else return -1
    func searchNextEmptyPosition()->Int{
        var searchEmptyPositonCount = 1
        while searchEmptyPositonCount <= passiveSkillCount{
            var position = currentSelectedPassiveButtonIndex + 1
            if position == 4{
                currentSelectedPassiveButtonIndex = 0
                position = 0
            }
            else{
                currentSelectedPassiveButtonIndex += 1
            }
            if !(passiveSkillView.subviews[position] as! SCPassiveSkillView).isSelected(){
                return position
            }
            searchEmptyPositonCount += 1
        }
        return -1
    }
}

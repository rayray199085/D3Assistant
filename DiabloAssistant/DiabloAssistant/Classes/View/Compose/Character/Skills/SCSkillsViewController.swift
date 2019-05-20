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
    @IBOutlet weak var activeSkillView: UIView!
    @IBOutlet weak var passiveSkillView: UIView!
    var characterViewModel: SCCharacterViewModel?
    private lazy var activeSkillIntroView: SCActiveSkillsIntroView = SCActiveSkillsIntroView.skillIntroView()
    private lazy var maskView = UIView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
        characterViewModel?.loadCharacter(completion: {[weak self] (isSuccess) in
            guard let character = self?.characterViewModel?.character else{
                return
            }
            self?.activeSkillIntroView.character = character
            for (index,skillView) in (self?.activeSkillView.subviews.enumerated())!{
                (skillView as! SCActiveSkillView).titleLabel.text = character.skillCategories?[index].name
            }
            SVProgressHUD.dismiss()
        })
    }
    
    @objc private func clickActiveSkillButton(button: UIButton){
        displayActiveIntroView()
        activeSkillIntroView.index = button.tag
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
            switch index{
            case 0:
                activeView.controlImageView.image = UIImage(named: "mouse_left_click")
            case 1:
                activeView.controlImageView.image = UIImage(named: "mouse_right_click")
            case 2, 3, 4, 5:
                activeView.controlImageView.image = UIImage(named: "skillNumber_\(index - 1)")
            default:
                break
            }
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
        switch tag {
        case 0:
            print(tag)
        case 1:
            print(tag)
        case 2:
            print(tag)
        default:
            break
        }
        hideActiveIntroView()
    }
}

//
//  SCProfileSkillController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileSkillController: UIViewController {
    @IBOutlet weak var passiveSkillView: UIView!
    
    @IBOutlet weak var activeSkillView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
            passiveSkillView.addSubview(v)
        }
        
    }
}

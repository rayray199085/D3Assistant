//
//  SCFollowerContentView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 27/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import ExpandingMenu
import SVProgressHUD

class SCFollowerContentView: UIView {
    @IBOutlet var levelLabels: [UILabel]!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var skillButtonViews: [UIView]!
    @IBOutlet weak var imageView: UIImageView!
    private var followerName: String?{
        didSet{
            loadFollowerInfo(followerName: followerName)
        }
    }
    var viewModel: SCFollowerViewModel?
    private let followerDictionary = [["name": "Reset","image":"follower_reset"],
                                      ["name": "Templar","image":"follower_1","slug": "templar"],
                                      ["name": "Scoundrel","image":"follower_2","slug": "scoundrel"],
                                      ["name": "Enchantress","image":"follower_3","slug": "enchantress"]]

    class func contentView()->SCFollowerContentView{
        let nib = UINib(nibName: "SCFollowerContentView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCFollowerContentView
        v.frame = UIScreen.main.bounds
        v.setupUI()
        return v
    }
    
    func setBackgroundImage(index: Int){
        imageView.image = UIImage(named: "follower_bg_\(index)")
    }
}
extension SCFollowerContentView: SCFollowerSkillButtonDelegate {
    func didClickIconButton(view: SCFollowerSkillButton, tag: Int) {
        // press 101 -> 101 shows frame, 102 shows mask
        // press 102 -> 102 shows frame, 101 shows mask
        view.setFrameOn()
        findMatchButton(index: tag)?.setMaskOn()
        textView.attributedText = nil
        let attrText = NSAttributedString.getSkillDescriptionAttributedText(skillName: view.skill?.name, skillLevel: view.skill?.level ?? 0, htmlString: view.skill?.descriptionHtml)
        textView.attributedText = attrText
    }
    
    func didClickFrameButton(view: SCFollowerSkillButton, tag: Int) {
        view.hideMaskAndFrame()
        findMatchButton(index: tag)?.hideMaskAndFrame()
        textView.attributedText = nil
    }
    
    func didClickMaskButton(view: SCFollowerSkillButton, tag: Int) {
        didClickFrameButton(view: view, tag: tag)
        didClickIconButton(view: view, tag: tag)
    }
}
private extension SCFollowerContentView{
    func findMatchButton(index: Int)->SCFollowerSkillButton?{
        let targetIndex = index % 2 == 0 ? index - 1 : index + 1
        for v in skillButtonViews{
            if v.tag == targetIndex{
                return v.subviews[0] as? SCFollowerSkillButton
            }
        }
        return nil
    }
}
private extension SCFollowerContentView{
    func setupUI(){
        setupMenuButton()
        for v in skillButtonViews{
            let btn = SCFollowerSkillButton.skillButton()
            btn.tag = v.tag
            v.addSubview(btn)
            btn.delegate = self
        }
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func setupMenuButton(){
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "chooser-button-tab")!, rotatedImage: UIImage(named: "chooser-button-tab-highlighted")!)
        menuButton.menuTitleDirection = .right

        menuButton.center = CGPoint(x: 32, y: textView.frame.minY - 32)
        addSubview(menuButton)
        var items = [ExpandingMenuItem]()
        for i in 0..<4{
            let dict = followerDictionary[i]
            let item = ExpandingMenuItem(size: menuButtonSize, title: dict["name"], image: UIImage(named: dict["image"]!)!, highlightedImage: nil, backgroundImage: nil, backgroundHighlightedImage: nil) { [weak self]() -> Void in
                self?.setBackgroundImage(index: i)
                switch i{
                case 0:
                    for v in self?.skillButtonViews ?? []{
                        (v.subviews[0] as! SCFollowerSkillButton).clearButtonContent()
                    }
                    for label in self?.levelLabels ?? []{
                        label.text = nil
                    }
                case 1, 2, 3:
                   self?.followerName = dict["slug"]
                default:
                    break
                }
                self?.textView.attributedText = nil
            }
            item.titleColor = SCButtonTitleColor
            items.append(item)
        }
        menuButton.addMenuItems(items)
    }
}

private extension SCFollowerContentView{
    func loadFollowerInfo(followerName: String?){
        guard let name = followerName else{
            return
        }
        // reset to normal
        for v in skillButtonViews{
            (v.subviews[0] as! SCFollowerSkillButton).hideMaskAndFrame()
        }
        SVProgressHUD.show()
        viewModel?.loadFollowerInfo(followerName: name
            , completion: { [weak self] (followerInfo, isSuccess) in
                SVProgressHUD.dismiss()
                for (index,v) in (self?.skillButtonViews ?? []).enumerated(){
                    (v.subviews[0] as! SCFollowerSkillButton).skill = followerInfo?.skills?[index]
                    self?.levelLabels[index / 2].text = "\(followerInfo?.skills?[index].level ?? 0)"
                }
        })
    }
}

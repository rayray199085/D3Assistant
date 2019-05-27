//
//  SCItemsViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import ExpandingMenu

class SCFollowerViewController: SCBaseViewController{
    private lazy var followerContentView = SCFollowerContentView.contentView()
    private let followerDictionary = [["name": "Templar","image":"follower_1"],
                                      ["name": "Scoundrel","image":"follower_2"],
                                      ["name": "Enchantress","image":"follower_3"]]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadData() {
       
    }
    override func setupUserView() {
        super.setupUserView()
        setupUI()
    }
}
private extension SCFollowerViewController{
    func setupUI(){
        view.addSubview(followerContentView)
        setupMenuButton()
    }
    func setupMenuButton(){
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "chooser-button-tab")!, rotatedImage: UIImage(named: "chooser-button-tab-highlighted")!)
        menuButton.menuTitleDirection = .right
       
        menuButton.center = CGPoint(x: 32, y: tabBarController!.tabBar.frame.minY - 32)
        view.addSubview(menuButton)
        
        var items = [ExpandingMenuItem]()
        for i in 0..<3{
            let dict = followerDictionary[i]
            let item = ExpandingMenuItem(size: menuButtonSize, title: dict["name"], image: UIImage(named: dict["image"]!)!, highlightedImage: nil, backgroundImage: nil, backgroundHighlightedImage: nil) { () -> Void in
               print(i)
            }
            item.titleColor = SCButtonTitleColor
            items.append(item)
        }

        menuButton.addMenuItems(items)
    }
}


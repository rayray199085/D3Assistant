//
//  SCProfileDetailsViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 31/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import DLSlideView

class SCProfileDetailsViewController: UIViewController {
    var hero: SCProfileHero?{
        didSet{
            title = hero?.name
        }
    }
    
    @IBOutlet weak var tabedSlideView: DLTabedSlideView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
private extension SCProfileDetailsViewController{
    func setupUI(){
        setupTabedSlideView()
    }
    func setupTabedSlideView(){
        tabedSlideView.baseViewController = self
        tabedSlideView.delegate = self
        tabedSlideView.tabItemNormalColor = UIColor.darkGray
        tabedSlideView.tabItemSelectedColor = SCButtonTitleColor
        tabedSlideView.tabbarTrackColor = SCButtonTitleColor
        tabedSlideView.tabbarBackgroundImage = UIImage(named: "tabbarBk")
        tabedSlideView.tabbarBottomSpacing = 3.0
        let crestImage = UIImage(named: "\(hero?.classSlug ?? "")_crest")?.modifyImageSize(size: CGSize(width: 30, height: 30), backgroundColor:SCNaviBarBgColor)
        let equipImage = UIImage(named: "hero_equip")?.modifyImageSize(size: CGSize(width: 30, height: 30), backgroundColor: SCNaviBarBgColor)
        let followerImage = UIImage(named: "follower_reset")?.modifyImageSize(size: CGSize(width: 30, height: 30), backgroundColor: SCNaviBarBgColor)
        guard let skillTab = DLTabedbarItem(title: "Skills", image: crestImage, selectedImage: crestImage),
            let equipTab = DLTabedbarItem(title: "Equipment", image: equipImage, selectedImage: equipImage),
            let followerTab = DLTabedbarItem(title: "Followers", image: followerImage, selectedImage: followerImage)else{
                return
        }
        tabedSlideView.tabbarItems = [equipTab,skillTab,followerTab]
        tabedSlideView.buildTabbar()
        tabedSlideView.selectedIndex = 0
    }
}
extension SCProfileDetailsViewController: DLTabedSlideViewDelegate{
    func numberOfTabs(in sender: DLTabedSlideView!) -> Int {
        return 3
    }
    
    func dlTabedSlideView(_ sender: DLTabedSlideView!, controllerAt index: Int) -> UIViewController? {
        switch index {
        case 0:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.red
            return vc
        case 1:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.orange
            return vc
        case 2:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.purple
            return vc
        default:
            return nil
        }
    }
    func dlTabedSlideView(_ sender: DLTabedSlideView!, didSelectedAt index: Int) {
      
        
    }
}

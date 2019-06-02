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
    var viewModel: SCProfileViewModel?
    
    private lazy var equipsViewController = SCProfileEquipmentController()
    private lazy var statsViewController = SCProfileStatisticsController()
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
    
        let statsImage = UIImage(named: "recipe_icon")?.modifyImageSize(size: CGSize(width: 25, height: 25), backgroundColor:SCNaviBarBgColor)
        
        let crestImage = UIImage(named: "\(hero?.classSlug ?? "")_crest")?.modifyImageSize(size: CGSize(width: 25, height: 25), backgroundColor:SCNaviBarBgColor)
        let equipImage = UIImage(named: "hero_equip")?.modifyImageSize(size: CGSize(width: 25, height: 25), backgroundColor: SCNaviBarBgColor)
        let followerImage = UIImage(named: "enchantress")?.modifyImageSize(size: CGSize(width: 25, height: 25), backgroundColor: SCNaviBarBgColor)
        guard let skillTab = DLTabedbarItem(title: "Skills", image: crestImage, selectedImage: crestImage),
            let equipTab = DLTabedbarItem(title: "Equips", image: equipImage, selectedImage: equipImage),
            let followerTab = DLTabedbarItem(title: "Followers", image: followerImage, selectedImage: followerImage),
            let statsTab = DLTabedbarItem(title: "Stats", image: statsImage, selectedImage: statsImage) else{
                return
        }
        tabedSlideView.tabbarItems = [statsTab,equipTab,skillTab,followerTab]
        tabedSlideView.buildTabbar()
        tabedSlideView.selectedIndex = 0
    }
}
extension SCProfileDetailsViewController: DLTabedSlideViewDelegate{
    func numberOfTabs(in sender: DLTabedSlideView!) -> Int {
        return 4
    }
    
    func dlTabedSlideView(_ sender: DLTabedSlideView!, controllerAt index: Int) -> UIViewController? {
        switch index {
        case 0:
            return statsViewController
        case 1:
            return equipsViewController
        case 2:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.orange
            return vc
        case 3:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.purple
            return vc
        default:
            return nil
        }
    }
    func dlTabedSlideView(_ sender: DLTabedSlideView!, didSelectedAt index: Int) {
        switch index {
        case 0:
            statsViewController.setBasicInfoContent(content: "\(hero?.level ?? 1) \(hero?.classSlug ?? "")")
            statsViewController.viewModel = viewModel
        case 1:
            guard let slug = hero?.classSlug else{
                return
            }
            equipsViewController.setBackgroundImage(imageName: "\(slug)_equip_\(hero?.gender ?? 0)")
        default:
            break
        }
    }
}

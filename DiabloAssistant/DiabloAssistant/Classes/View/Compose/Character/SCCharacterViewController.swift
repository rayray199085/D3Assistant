//
//  SCCharacterViewController.swift
//  SCCharacterViewController
//
//  Created by Stephen Cao on 18/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import DLSlideView

class SCCharacterViewController: UIViewController {
    var characterName: String?{
        didSet{
            navigationItem.title = characterName
        }
    }
    
    @IBOutlet weak var tabedSlideView: DLTabedSlideView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func goBack(){
        dismiss(animated: true, completion: nil)
    }
}
private extension SCCharacterViewController{
    func setupUI(){
        setupNavigationBar()
        setupTabedSlideView()
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(goBack), isBack: true)
    }
    func setupTabedSlideView(){
        tabedSlideView.baseViewController = self
        tabedSlideView.delegate = self
        tabedSlideView.tabItemNormalColor = UIColor.darkGray
        tabedSlideView.tabItemSelectedColor = SCButtonTitleColor
        tabedSlideView.tabbarTrackColor = SCButtonTitleColor
        tabedSlideView.tabbarBackgroundImage = UIImage(named: "tabbarBk")
        tabedSlideView.tabbarBottomSpacing = 3.0
        let crestImage = UIImage(named: "\(characterName!)_crest")?.modifyImageSize(size: CGSize(width: 30, height: 30), backgroundColor:SCNaviBarBgColor)
        let equipImage = UIImage(named: "hero_equip")?.modifyImageSize(size: CGSize(width: 30, height: 30), backgroundColor: SCNaviBarBgColor)
        guard let skillTab = DLTabedbarItem(title: "Skills", image: crestImage, selectedImage: crestImage),
            let equipTab = DLTabedbarItem(title: "Equipment", image: equipImage, selectedImage: equipImage) else{
                return
        }
        tabedSlideView.tabbarItems = [skillTab, equipTab]
        tabedSlideView.buildTabbar()
        tabedSlideView.selectedIndex = 0
    }
}
extension SCCharacterViewController: DLTabedSlideViewDelegate{
    func numberOfTabs(in sender: DLTabedSlideView!) -> Int {
        return 2
    }
    
    func dlTabedSlideView(_ sender: DLTabedSlideView!, controllerAt index: Int) -> UIViewController? {
        switch index {
        case 0:
            let v1 = SCSkillsViewController()
            return v1
        case 1:
            let v2 = SCEquipmentViewController()
            v2.characterName = characterName
            return v2
        default:
            return nil
        }
    }

}

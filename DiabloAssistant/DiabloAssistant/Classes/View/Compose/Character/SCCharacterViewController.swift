//
//  SCCharacterViewController.swift
//  SCCharacterViewController
//
//  Created by Stephen Cao on 18/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import DLSlideView
import SVProgressHUD

class SCCharacterViewController: UIViewController {
    private var equipmentViewController: SCEquipmentViewController?
    private var characterViewModel : SCCharacterViewModel?
    private var equipmentViewModel : SCEquipmentViewModel?{
        didSet{
            equipmentViewController?.viewModel = equipmentViewModel
        }
    }
    var characterName: String?{
        didSet{
            guard let characterName = characterName else{
                return
            }
            navigationItem.title = characterName
            characterViewModel = SCCharacterViewModel(characterName: characterName)
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
            let skillViewController = SCSkillsViewController()
            skillViewController.characterViewModel = characterViewModel
            return skillViewController
        case 1:
            equipmentViewController = SCEquipmentViewController()
            equipmentViewController!.characterName = characterName
            return equipmentViewController
        default:
            return nil
        }
    }
    func dlTabedSlideView(_ sender: DLTabedSlideView!, didSelectedAt index: Int) {
        // equipment page is being shown
        if index == 1{
            guard let name = characterViewModel?.character?.name else{
                SVProgressHUD.showError(withStatus: "Please try again later")
                return
            }
            if equipmentViewModel == nil{
                equipmentViewModel = SCEquipmentViewModel(characterName: name)
            }
        }else{
            SVProgressHUD.dismiss()
        }
    }

}

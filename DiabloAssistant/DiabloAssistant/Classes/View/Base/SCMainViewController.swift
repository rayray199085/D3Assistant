//
//  SCMainViewController.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCMainViewController: UITabBarController {
    
    private lazy var composeButton: UIButton = UIButton.imageButton(
        withNormalImageName: "compose_button_normal",
        andWithHighlightedImageName: "compose_button_highlighted")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        setupChildControllers()
        setupComposeButton()
        tabBar.barTintColor = UIColor.black
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginNotification), name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
        disableTabBarItem(index: 2)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
    }
    
    @objc private func handleLoginNotification(notification: Notification){
        let nav = UINavigationController(rootViewController: SCOAuthViewController())
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func clickComposeButton(){
        if !SCNetworkManager.shared.userLogon{
            NotificationCenter.default.post(name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
            return
        }
        let composeView = SCComposeTypeView.composeTypeView()
        composeView.show { [weak composeView] (characterName, characterEquipmentName) in
            let vc = SCCharacterViewController()
            vc.characterName = characterName
            vc.characterEquipmentName = characterEquipmentName
            let nav = SCNavigationViewController(rootViewController: vc)
            self.present(nav, animated: true, completion: {
                composeView?.removeFromSuperview()
            })
        }
    }
}
private extension SCMainViewController{
    
    /// setup child controllers by initializing an array of dictionary
    func setupChildControllers(){
        let array = [
        ["title": "News","clsName":"SCNewsViewController","imageName":"news"],
        ["title": "Rankings","clsName":"SCRankingsViewController","imageName":"rank"],
        ["clsName":"UIViewController"],
        ["title": "Items","clsName":"SCItemsViewController","imageName":"items"],
        ["title": "Settings","clsName":"SCSettingsViewController","imageName":"settings"]]
        var childControllers = [UIViewController]()
        for dict in array{
            childControllers.append(getController(dict: dict))
        }
        viewControllers = childControllers
    }
    
    /// get child controllers
    ///
    /// - Parameter dict: dictionary contains titile, class and tab bar image
    /// - Returns: child controller
    func getController(dict: [String: Any])->UIViewController{
        guard let clsName = dict["clsName"] as? String,
              let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String else{
                return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        let normalImageName = "tabbar_\(imageName)"
        vc.tabBarItem.image = UIImage(named: normalImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(
            named: normalImageName + "_selected")?.withRenderingMode(
                UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor : SCButtonTitleColor],
            for: UIControl.State.highlighted)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray,NSAttributedString.Key.font: UIFont(name: "Exocet", size: 10)!], for: [])
        let nav = SCNavigationViewController(rootViewController: vc)
        return nav
    }
    /// setup compose button
    func setupComposeButton(){
        
        tabBar.addSubview(composeButton)
        // calculate button location
        let itemWidth = tabBar.bounds.width / CGFloat(children.count)
        composeButton.frame = tabBar.bounds.insetBy(dx: itemWidth * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(clickComposeButton), for: UIControl.Event.touchUpInside)
    }
}

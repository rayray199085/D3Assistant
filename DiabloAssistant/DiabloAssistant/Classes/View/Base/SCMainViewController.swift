//
//  SCMainViewController.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginNotification), name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
    }
    
    @objc private func handleLoginNotification(notification: Notification){
        let nav = UINavigationController(rootViewController: SCOAuthViewController())
        present(nav, animated: true, completion: nil)
    }
}
private extension SCMainViewController{
    func setupChildControllers(){
        let array = [
        ["title": "Home","clsName":"SCHomeViewController","imageName":"home"],
        ["title": "Message","clsName":"SCMessageViewController","imageName":"message_center"],
        ["title": "Discover","clsName":"SCDiscoverViewController","imageName":"discover"],
        ["title": "Profile","clsName":"SCProfileViewController","imageName":"profile"]]
        var childControllers = [UIViewController]()
        for dict in array{
            childControllers.append(getController(dict: dict))
        }
        viewControllers = childControllers
    }
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
        vc.tabBarItem.image = UIImage(named: normalImageName)
        vc.tabBarItem.selectedImage = UIImage(
            named: normalImageName + "_selected")?.withRenderingMode(
                UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor : UIColor.orange],
            for: UIControl.State.highlighted)
        let nav = SCNavigationViewController(rootViewController: vc)
        return nav
    }
}

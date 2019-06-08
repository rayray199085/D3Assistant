//
//  SCSettingsViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
private let appId = "702071888"
private let emailAddress = "stephen.cao0805@outlook.com"
class SCMoreViewController: UIViewController {
    private lazy var functionView = SCMoreFunctionView.functionView()
    private lazy var hintView = SCMoreHintView.hintView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
private extension SCMoreViewController{
    func setupUI(){
        view.addSubview(functionView)
        functionView.delegate = self
        hintView.isHidden = true
        hintView.delegate = self
        navigationController?.view.addSubview(hintView)
    }
}
extension SCMoreViewController: SCMoreHintViewDelegate{
    func didClickConfirmButton(view: SCMoreHintView, index: Int) {
        if index == 0{
            guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) else{
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            guard let url = URL(string: "mailto:\(emailAddress)") else{
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        hintView.isHidden = true
    }
    
    func didClickMaskButton(view: SCMoreHintView) {
        hintView.isHidden = true
    }
    
}
extension SCMoreViewController: SCMoreFunctionViewDelegate{
    func didClickTableViewCell(view: SCMoreFunctionView, row: Int, title: String?, content: String?) {
        hintView.isHidden = false
        hintView.index = row
        hintView.setTitleText(title: title)
        hintView.setTextViewContent(content: content)
    }
}

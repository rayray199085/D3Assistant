//
//  SCProfileViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCProfileViewController: SCBaseViewController {
    private lazy var profileView = SCProfileRecordView.recordView()
    private lazy var profileInputView = SCProfileInputView.inputView()
    private lazy var viewModel = SCProfileViewModel()
    
    private var profileData: SCProfileData? {
        didSet{
            profileView.profileData = profileData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadData() {
        
    }
    override func setupUserView() {
        super.setupUserView()
        setupUI()
    }
    @objc private func addNewProfile(){
        profileInputView.isHidden = false
        profileInputView.setFirstResponder()
    }
}
private extension SCProfileViewController{
    func setupUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewProfile))
        navigationController?.navigationBar.tintColor = SCButtonTitleColor
        view.addSubview(profileView)
        view.addSubview(profileInputView)
        profileInputView.isHidden = true
        profileInputView.delegate = self
        profileView.delegate = self
    }
}
extension SCProfileViewController: SCProfileInputViewDelegate{
    func getRegionAndBattleTag(view: SCProfileInputView, region: String?, battleTag: String?) {
        guard let region = region,
            let battleTag = battleTag else{
                return
        }
        SVProgressHUD.show()
        viewModel.loadPlayerProfile(region: region, battleTag: battleTag) { [weak self](profileData, isSuccess) in
            if !isSuccess || profileData == nil || profileData?.battleTag == nil{
                SVProgressHUD.showInfo(withStatus: "Incorrect input")
                return
            }
            SVProgressHUD.showInfo(withStatus: "Success")
            self?.profileData = profileData
        }
    }
}
extension SCProfileViewController: SCProfileRecordViewDelegate{
    func didSelectedHero(view: SCProfileRecordView, button: SCProfileButton, hero: SCProfileHero?) {
        let vc = SCProfileDetailsViewController()
        vc.hero = hero
        navigationController?.pushViewController(vc, animated: true)
    }
}



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
    private lazy var profileInputView: SCProfileInputView = {
        let v = SCProfileInputView.inputView()
        v.readTagRecords()
        return v
    }()
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
        profileInputView.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
    }
}
private extension SCProfileViewController{
    func setupUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewProfile))
        navigationController?.navigationBar.tintColor = SCButtonTitleColor
        view.addSubview(profileView)
        navigationController?.view.addSubview(profileInputView)
        profileInputView.isHidden = true
        profileInputView.delegate = self
        profileView.delegate = self
    }
}
extension SCProfileViewController: SCProfileInputViewDelegate{
    func getRegionAndBattleTag(view: SCProfileInputView, region: String?, battleTag: String?, completion: @escaping (Bool) -> ()) {
        guard let region = region,
            let battleTag = battleTag else{
                completion(false)
                return
        }
        SVProgressHUD.show()
        viewModel.loadPlayerProfile(region: region, battleTag: battleTag) { [weak self](profileData, isSuccess) in
            if !isSuccess || profileData == nil || profileData?.battleTag == nil{
                SVProgressHUD.showInfo(withStatus: "Incorrect input")
                completion(false)
                return
            }
            SVProgressHUD.showInfo(withStatus: "Success")
            self?.profileData = profileData
            self?.profileData?.region = region
            completion(true)
        }
    }
}
extension SCProfileViewController: SCProfileRecordViewDelegate{
    func didSelectedHero(view: SCProfileRecordView, button: SCProfileButton, hero: SCProfileHero?) {
        let vc = SCProfileDetailsViewController()
        vc.hero = hero
        SVProgressHUD.show()
        viewModel.loadHeroDetails(id: hero?.id) { [weak self](isSuccess) in
            if !isSuccess{
                SVProgressHUD.showInfo(withStatus: "Connection error")
                return
            }
            SVProgressHUD.dismiss()
            vc.viewModel = self?.viewModel
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



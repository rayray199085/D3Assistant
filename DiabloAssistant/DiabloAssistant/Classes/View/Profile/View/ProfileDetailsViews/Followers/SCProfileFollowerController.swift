//
//  SCProfileFollowerController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 5/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD
class SCProfileFollowerController: UIViewController {
    private lazy var detailsView = SCProfileHeroEquipDetailsView.detailsView()
    
    private var hasLoadFollowerDetails: Bool = false
    var viewModel: SCProfileViewModel?{
        didSet{
            if hasLoadFollowerDetails{
                return
            }
            SVProgressHUD.show()
            viewModel?.loadFollowerInfo(completion: { [weak self](isSuccess) in
                self?.hasLoadFollowerDetails = true
                self?.contentView.follower = self?.viewModel?.followers?.scoundrel
                SVProgressHUD.dismiss()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        
        navigationController?.view.addSubview(detailsView)
        detailsView.isHidden = true
        detailsView.delegate = self
    }
    
    @IBOutlet weak var contentView: SCProfileFollowerDetailsView!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var followerNameLabel: UILabel!
    @IBAction func segment(_ sender: UISegmentedControl) {
        detailsImageView.image = UIImage(named: "follower_details_\(sender.selectedSegmentIndex)")
        contentView.follower = viewModel?.followers?.followers?[sender.selectedSegmentIndex]
        switch sender.selectedSegmentIndex {
        case 0:
            followerNameLabel.text = "SCOUNDREL"
        case 1:
            followerNameLabel.text = "TEMPLAR"
        case 2:
            followerNameLabel.text = "ENCHANTRESS"
        default:
            break
        }
    }
}
extension SCProfileFollowerController: SCProfileFollowerDetailsViewDelegate{
    func didClickSkillButton(view: SCProfileFollowerDetailsView, skill: SCProfileSkillItem?) {
        if skill == nil{
            return
        }
        detailsView.isHidden = false
        detailsView.skill = skill
    }
    
    func didClickEquipButton(view: SCProfileFollowerDetailsView, item: SCProfileEquipmentItem?) {
        if item == nil{
            return 
        }
        detailsView.isHidden = false
        detailsView.item = item
    }
}
extension SCProfileFollowerController: SCProfileHeroEquipDetailsViewDelegate{
    func didClickEquipMaskButton(view: SCProfileHeroEquipDetailsView) {
        detailsView.isHidden = true
    }
}

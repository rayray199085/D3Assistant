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
    var hasLoadFollowerDetails: Bool = false
    var viewModel: SCProfileViewModel?{
        didSet{
            if hasLoadFollowerDetails{
                return
            }
            SVProgressHUD.show()
            viewModel?.loadFollowerInfo(completion: { [weak self](isSuccess) in
                self?.hasLoadFollowerDetails = true
                self?.detailsView.follower = self?.viewModel?.followers?.scoundrel
                SVProgressHUD.dismiss()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.delegate = self
    }
    
    @IBOutlet weak var detailsView: SCProfileFollowerDetailsView!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var followerNameLabel: UILabel!
    @IBAction func segment(_ sender: UISegmentedControl) {
        detailsImageView.image = UIImage(named: "follower_details_\(sender.selectedSegmentIndex)")
        detailsView.follower = viewModel?.followers?.followers?[sender.selectedSegmentIndex]
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
    func didClickSkillButton(view: SCProfileFollowerDetailsView, index: Int) {
        print(index)
    }
    func didClickEquipButton(view: SCProfileFollowerDetailsView, index: Int) {
        print(index)
    }
}

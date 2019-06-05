//
//  SCProfileFollowerController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 5/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileFollowerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var followerNameLabel: UILabel!
    @IBAction func segment(_ sender: UISegmentedControl) {
        detailsImageView.image = UIImage(named: "follower_details_\(sender.selectedSegmentIndex)")
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

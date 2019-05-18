//
//  SCEquipmentViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 18/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCEquipmentViewController: UIViewController {
    var characterName: String?
    
    @IBOutlet weak var equipmentImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
private extension SCEquipmentViewController{
    func setupUI(){
        guard let characterName = characterName else {
            return
        }
        equipmentImageView.image = UIImage(named: "\(characterName)_equip")
    }
}

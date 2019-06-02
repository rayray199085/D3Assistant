//
//  SCProfileEquipmentController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileEquipmentController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet var equipmentButtons: [SCEquipmentButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func setBackgroundImage(imageName: String){
        bgImageView.image = UIImage(named: imageName)
    }
    @IBAction func clickEquipmentButton(_ sender: UIButton) {
        
    }
}

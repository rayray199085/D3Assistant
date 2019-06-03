//
//  SCProfilePowerView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 3/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCProfilePowerViewDelegate: NSObjectProtocol {
    func didClickEquipButton(powerView: SCProfilePowerView, slugId: String)
}

class SCProfilePowerView: UIView {
    weak var delegate: SCProfilePowerViewDelegate?
    var power: SCProfileLegendaryPowerItem?{
        didSet{
            clearEquipStatus()
            equipButton.isEnabled = true
            equipBackgroundImageView.image = UIImage(named: "Active-Default")
            equipButton.setImage(power?.iconImage, for: [])
           
        }
    }
    
    @IBOutlet weak var equipBackgroundImageView: UIImageView!
    @IBOutlet weak var equipButton: UIButton!
    @IBAction func clickEquipButton(_ sender: UIButton) {
        guard let slug = power?.slug,
            let id = power?.id else{
                return
        }
        delegate?.didClickEquipButton(powerView: self, slugId: "\(slug)-\(id)")
    }
    
    class func powerView()->SCProfilePowerView{
        let nib = UINib(nibName: "SCProfilePowerView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfilePowerView
        v.frame = CGRect(x: 0, y: 0, width: 115, height: 190)
        return v
    }
    
    func setEquipBackgroundImage(index: Int){
        equipBackgroundImageView.image = UIImage(named: "empty_\(index)")
        equipButton.tag = index
        equipButton.isEnabled = false
    }
    
    func clearEquipStatus(){
        equipBackgroundImageView.image = UIImage(named: "empty_\(equipButton.tag)")
        equipButton.setImage(nil, for: [])
    }
    
    override func awakeFromNib() {
    }
}

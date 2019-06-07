//
//  SCProfileEquipmentDetailsView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 3/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCProfileEquipmentDetailsViewDelegate: NSObjectProtocol{
    func dismissDetailsView()
}

class SCProfileEquipmentDetailsView: UIView {
    var details: SCEquipmentItemDetails?{
        didSet{
            guard let details = details,
                  let color = details.color else{
                return
            }
            titleBgImageView.image = UIImage(named: "frame_\(color)")
            var titleColor: UIColor?
            switch color {
            case "blue":
                titleColor = SCItemBlue
            case "white":
                titleColor = UIColor.white
            case "yellow":
                titleColor = SCItemYellow
            case "orange":
                titleColor = SCItemOrange
            case "green":
                titleColor = SCItemGreen
            default:
                break
            }
            titleLabel.textColor = titleColor
            titleLabel.text = details.name
            titleLabel.font = details.name?.count ?? 0 > 30 ? UIFont(name: "Exocet", size: 11)! : UIFont(name: "Exocet", size: 15)!
            textView.attributedText = NSAttributedString.getItemDescriptionAttributedText(details: details, withoutTitle: true)
        }
    }
    @IBOutlet weak var titleBgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    weak var delegate: SCProfileEquipmentDetailsViewDelegate?
    
    class func detailsView()->SCProfileEquipmentDetailsView{
        let nib = UINib(nibName: "SCProfileEquipmentDetailsView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileEquipmentDetailsView
        v.frame = UIScreen.main.bounds
        return v
    }
    @IBAction func clickDetailsMaskButton(_ sender: Any) {
        delegate?.dismissDetailsView()
    }
}


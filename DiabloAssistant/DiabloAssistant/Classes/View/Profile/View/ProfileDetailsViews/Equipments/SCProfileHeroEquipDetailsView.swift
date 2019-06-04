//
//  SCProfileHeroEquipDetailsView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCProfileHeroEquipDetailsViewDelegate: NSObjectProtocol {
    func didClickEquipMaskButton(view: SCProfileHeroEquipDetailsView)
}

class SCProfileHeroEquipDetailsView: UIView {
    weak var delegate: SCProfileHeroEquipDetailsViewDelegate?
    var item: SCProfileEquipmentItem?{
        didSet{
            guard let item = item,
                let color = item.displayColor else{
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
            titleLabel.text = item.name
            textView.attributedText = NSAttributedString.getHeroItemDescription(details: item)
            textView.scrollRangeToVisible(NSMakeRange(0, 0))
        }
    }
    class func detailsView()->SCProfileHeroEquipDetailsView{
        let nib = UINib(nibName: "SCProfileHeroEquipDetailsView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileHeroEquipDetailsView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    @IBAction func clickEquipMaskButton(_ sender: Any) {
        delegate?.didClickEquipMaskButton(view: self)
    }
    @IBOutlet weak var titleBgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
}

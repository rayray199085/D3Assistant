//
//  SCCollectionViewButton.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 25/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCollectionViewButton: UIView {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    var item : SCEquipmentItem?{
        didSet{
            iconImage.image = item?.iconImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            guard let name = item?.details?.color else {
                return
            }
            backgroundImage.image = UIImage(named: "color_\(name)")
        }
    }
    class func viewButton()->SCCollectionViewButton{
        let nib = UINib(nibName: "SCCollectionViewButton", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCCollectionViewButton
        v.frame = CGRect(x: 0, y: 0, width: 64, height: 128)
        v.backgroundImage.mxCornerRadius = 10.0
        return v
    }
}

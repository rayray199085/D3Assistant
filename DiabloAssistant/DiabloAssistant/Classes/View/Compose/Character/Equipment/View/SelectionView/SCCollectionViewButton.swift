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
    
    class func viewButton()->SCCollectionViewButton{
        let nib = UINib(nibName: "SCCollectionViewButton", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCCollectionViewButton
        v.frame = CGRect(x: 0, y: 0, width: 64, height: 128)
        return v
    }
    
    func setIcon(image: UIImage?){
        iconImage.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
    func setTypeBackgroundImage(name: String?){
        guard let name = name else {
            return
        }
        backgroundImage.image = UIImage(named: "color_\(name)")
    }
}

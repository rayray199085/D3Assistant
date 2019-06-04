//
//  SCProfileEquipGemView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 4/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCProfileEquipGemViewDelegate: NSObjectProtocol {
    func didClickGemButton(view: SCProfileEquipGemView, index: Int)
}

class SCProfileEquipGemView: UIView {
    weak var delegate: SCProfileEquipGemViewDelegate?
    
    @IBOutlet weak var gemButton: UIButton!
    var index: Int = 0
   
    class func gemView(index: Int)->SCProfileEquipGemView{
        let nib = UINib(nibName: "SCProfileEquipGemView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileEquipGemView
        v.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        v.index = index
        return v
    }
    
    
    @IBAction func clickGemButton(_ sender: Any) {
        delegate?.didClickGemButton(view: self, index: index)
    }
    
    func setGemImage(image: UIImage?){
        gemButton.setBackgroundImage(image, for: [])
    }
}

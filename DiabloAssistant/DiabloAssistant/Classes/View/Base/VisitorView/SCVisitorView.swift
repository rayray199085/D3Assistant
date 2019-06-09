//
//  SCVisitorView.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCVisitorView: UIView {
    
    var visitorInfo: [String: String]?{
        didSet{
            titleLable.text = visitorInfo?["message"]
            guard let imageName = visitorInfo?["imageName"] else{
                return 
            }
            imageView.image = UIImage(named: imageName)
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    class func visitorView()->SCVisitorView{
        let nib = UINib(nibName: "SCVisitorView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCVisitorView
        v.frame = UIScreen.main.bounds
        return v
    }
    
}

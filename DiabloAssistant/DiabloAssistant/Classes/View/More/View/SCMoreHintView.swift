//
//  SCMoreHintView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 8/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCMoreHintViewDelegate: NSObjectProtocol {
    func didClickMaskButton(view: SCMoreHintView)
    func didClickConfirmButton(view: SCMoreHintView, index: Int)
}
class SCMoreHintView: UIView {
    
    weak var delegate: SCMoreHintViewDelegate?
    class func hintView()->SCMoreHintView{
        let nib = UINib(nibName: "SCMoreHintView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCMoreHintView
        v.frame = UIScreen.main.bounds
        v.confirmButton.isHidden = true
        return v
    }
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var index: Int = 0{
        didSet{
            confirmButton.isHidden = index > 1
        }
    }
    func setTitleText(title: String?){
        titleLabel.text = title
    }
    func setTextViewContent(content: String?){
        textView.text = content
    }
    
    @IBAction func clickConfirmButton(_ sender: Any) {
        delegate?.didClickConfirmButton(view: self, index: index)
    }
    @IBAction func clickMaskButton(_ sender: Any) {
        delegate?.didClickMaskButton(view: self)
    }
}

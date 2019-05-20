//
//  SCActiveSkillRuneView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 20/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCActiveSkillRuneViewDelegate: NSObjectProtocol {
    func didClickRune(view: SCActiveSkillRuneView, tag: Int)
}
class SCActiveSkillRuneView: UIView {
    @IBOutlet weak var selectedFrame: UIImageView!
    @IBOutlet weak var runeButton: UIButton!
    weak var delegate: SCActiveSkillRuneViewDelegate?
    
    class func runeView()->SCActiveSkillRuneView{
        let nib = UINib(nibName: "SCActiveSkillRuneView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCActiveSkillRuneView
        v.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return v
    }
    
    override func awakeFromNib() {
        cancelSelection()
    }
    
    func cancelSelection(){
        selectedFrame.isHidden = true
    }
    
    func didSelected(){
        selectedFrame.isHidden = false
    }
    
    @IBAction func clickRuneButton(_ sender: UIButton) {
        delegate?.didClickRune(view: self, tag: sender.tag)
    }
    
}

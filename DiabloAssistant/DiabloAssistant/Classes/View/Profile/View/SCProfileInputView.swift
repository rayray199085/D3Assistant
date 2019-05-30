//
//  SCProfileInputView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCProfileInputViewDelegate: NSObjectProtocol {
    func getRegionAndBattleTag(view: SCProfileInputView, region: String?, battleTag: String?)
}
class SCProfileInputView: UIView {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet var regionTextField: UITextField!
    @IBOutlet weak var battleTagTextField: UITextField!
    
    var hasFilledRegion: Bool = false
    var hasFilledBattleTag: Bool = false
    
    weak var delegate: SCProfileInputViewDelegate?
    
    class func inputView()->SCProfileInputView{
        let nib = UINib(nibName: "SCProfileInputView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileInputView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        regionTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        battleTagTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    func setFirstResponder(){
        regionTextField.becomeFirstResponder()
    }
    
    @IBAction func clickConfirmButton(_ sender: Any) {
        isHidden = true
        delegate?.getRegionAndBattleTag(view: self, region: regionTextField.text, battleTag: battleTagTextField.text)
        clearAllInput()
    }
    @IBAction func clickCloseButton(_ sender: Any) {
        isHidden = true
        clearAllInput()
    }

    func clearAllInput(){
        regionTextField.text?.removeAll()
        battleTagTextField.text?.removeAll()
        endEditing(true)
    }
    @objc private func textFieldDidChange(textField: UITextField){
        if textField.tag == 101 {
            hasFilledRegion = textField.hasText
        }
        if textField.tag == 102 {
            hasFilledBattleTag = textField.hasText
        }
        confirmButton.isEnabled = hasFilledBattleTag && hasFilledRegion
    }
}

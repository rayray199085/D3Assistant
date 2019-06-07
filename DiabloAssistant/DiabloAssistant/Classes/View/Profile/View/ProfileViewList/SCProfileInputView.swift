//
//  SCProfileInputView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell_id"
private let fileName = "tagRecords.json"

protocol SCProfileInputViewDelegate: NSObjectProtocol {
    func getRegionAndBattleTag(view: SCProfileInputView, region: String?, battleTag: String?,completion: @escaping (_ isSuccess: Bool)->())
}
class SCProfileInputView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet var regionTextField: UITextField!
    @IBOutlet weak var battleTagTextField: UITextField!
    private var records = [SCProfileInputRecord]()
    
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
        setupTableView()
    }
    
    func setFirstResponder(){
        regionTextField.becomeFirstResponder()
    }
    
    @IBAction func clickConfirmButton(_ sender: Any) {
        isHidden = true
        delegate?.getRegionAndBattleTag(view: self, region: regionTextField.text?.lowercased(), battleTag: getUrlBattleTag(tag: battleTagTextField.text), completion: { [weak self](isSuccess) in
            if isSuccess{
                guard let battleTag = self?.getUrlBattleTag(tag: self?.battleTagTextField.text),
                    let region = self?.regionTextField.text?.lowercased() else{
                        return
                }
                let res = self?.records.filter({ (rec) -> Bool in
                    return rec.battleTag == battleTag && rec.region == region
                })
                let newRec: SCProfileInputRecord
                if (res?.count ?? 0) > 0{
                    newRec = res![0]
                    newRec.loginCount += 1
                    self?.records.removeAll(where: { (rec) -> Bool in
                        return rec == newRec
                    })
                }else{
                    newRec = SCProfileInputRecord()
                    newRec.setInfo(battleTag: battleTag, region: region)
                }
                self?.records.insert(newRec, at: 0)
                self?.saveTagRecord()
                self?.clearAllInput()
                self?.tableView.reloadData()
            }
        })
        
    }
    @IBAction func clickCloseButton(_ sender: Any) {
        isHidden = true
        clearAllInput()
    }

    func clearAllInput(){
        regionTextField.text?.removeAll()
        battleTagTextField.text?.removeAll()
        confirmButton.isEnabled = battleTagTextField.hasText && regionTextField.hasText
        endEditing(true)
    }
    @objc private func textFieldDidChange(textField: UITextField){
        confirmButton.isEnabled = battleTagTextField.hasText && regionTextField.hasText
    }
}

extension SCProfileInputView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCProfileRecordCell
        cell.record = records[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        battleTagTextField.text = records[indexPath.row].battleTag
        regionTextField.text = records[indexPath.row].region
        confirmButton.isEnabled = battleTagTextField.hasText && regionTextField.hasText
    }
}
extension SCProfileInputView{
    private func saveTagRecord(){
        var array =  [[String: Any]]()
        for rec in records{
            guard let dict = rec.yy_modelToJSONObject() as? [String: Any] else{
                continue
            }
            array.append(dict)
        }
        guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else{
            return
        }
        try? data.write(to: URL(fileURLWithPath: NSString.getDocumentDirectory().appendingPathComponent(fileName)))
    }
    
    func readTagRecords(){
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: NSString.getDocumentDirectory().appendingPathComponent(fileName))),
            let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                return
        }
        records.removeAll()
        for dict in array{
            guard let rec = SCProfileInputRecord.yy_model(with: dict) else{
                continue
            }
            records.append(rec)
        }
        records.sort { (rec0, rec1) -> Bool in
            return rec0.loginCount > rec1.loginCount
        }
        tableView.reloadData()
    }
}
private extension SCProfileInputView{
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.register(UINib(nibName: "SCProfileRecordCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func getUrlBattleTag(tag: String?)->String{
        guard var battleTag = tag else{
            return ""
        }
        battleTag = battleTag.removingWhitespaces()
        battleTag = (battleTag as NSString).replacingOccurrences(of: "#", with: "-")
        return battleTag
    }
}

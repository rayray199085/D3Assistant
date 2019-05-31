//
//  SCEquipmentViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 18/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD
import TCPickerView

class SCEquipmentViewController: UIViewController {
    
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var dpsLabel: UILabel!
    @IBOutlet var equipmentButtons: [SCEquipmentButton]!
    
    @IBOutlet weak var switchOffHandButton: UISwitch!
    @IBOutlet weak var itemSelectionView: SCItemSelectionView!
    @IBOutlet weak var selectionMaskView: UIView!
    @IBOutlet weak var offHandButton: UIButton!
    
    private var pressedButtonTag: Int = 0
    private var selectedItems: [SCEquipmentItem]?{
        didSet{
            itemSelectionView.items = selectedItems
            itemSelectionView.reloadCollectionViewData()
        }
    }
    
    private let theme = TCPickerViewDarkTheme()
    private lazy var buttonIndexDict = [101: "heads",102: "shoulders",103: "amulets",
                                   104: "torsos",105: "hands", 106: "wrists",
                                   107: "waists",108: "rings",109: "rings",
                                   110: "legs", 111: "weapons",112: "offHands",113: "feet"]
    var characterName: String?
    var viewModel: SCEquipmentViewModel?{
        didSet{
            SVProgressHUD.show()
            viewModel?.loadEquipmentTypeList(completion: { (isSuccess) in
                SVProgressHUD.dismiss()
            })
        }
    }
    
    @IBOutlet weak var equipmentImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        for btn in equipmentButtons{
            btn.imageView?.contentMode = .scaleAspectFill
            btn.imageView?.clipsToBounds = false
        }
    }
    
    @IBAction func clickEquipmentButton(_ sender: SCEquipmentButton) {
        guard let propertyName = buttonIndexDict[sender.tag],
              let itemTypes = viewModel?.value(forKey: propertyName) as? [SCItemCommonTypes] else{
            return
        }
        pressedButtonTag = sender.tag
        itemSelectionView.isWeaponType = propertyName == "weapons"
        showTypeSelectionView(title: propertyName.capitalizingFirstLetter(), itemTypes: itemTypes)
    }
    
    @IBAction func switchOffHandStatus(_ sender: UISwitch){
        buttonIndexDict[112] = sender.isOn ? "offHands" : "weapons"
        let buttonTitle = sender.isOn ? "OFFHANDS" : "WEAPONS"
        offHandButton.setTitle(buttonTitle, for: [])
    }
    
    
    @IBAction func clickResetButton(_ sender: Any) {
        setupEquipmentButtons()
        switchOffHandButton.setOn(true, animated: true)
        switchOffHandStatus(switchOffHandButton)
        dpsLabel.text = "DPS: 0.0"
        armorLabel.text = "ARMOR: 0.0"
    }
}
private extension SCEquipmentViewController{
    func setupUI(){
        guard let characterName = characterName else {
            return
        }
        setupEquipmentButtons()
        equipmentImageView.image = UIImage(named: "\(characterName)_equip_1")
        setupItemSelectionView()
        hideItemSelectionView()
    }
    func setupItemSelectionView(){
        itemSelectionView.delegate = self
    }
    func showItemSelectionView(){
        selectionMaskView.isHidden = false
        itemSelectionView.isHidden = false
    }
    func hideItemSelectionView(){
        selectionMaskView.isHidden = true
        itemSelectionView.isHidden = true
    }
    func setupEquipmentButtons(){
        for btn in equipmentButtons{
            btn.setTitle(buttonIndexDict[btn.tag], for: [])
            btn.resetButtonContent()
        }
    }
}
private extension SCEquipmentViewController{
    func showTypeSelectionView(title: String, itemTypes: [SCItemCommonTypes]?){
        var titles = [String]()

        for item in itemTypes ?? []{
            titles.append(item.itemType)
        }
        var picker: TCPickerViewInput = TCPickerView()
        picker.title = title
        let itemName = titles
        let values = itemName.map { TCPickerView.Value(title: $0) }
        picker.values = values
        picker.delegate = self
        picker.theme = theme
        picker.selection = .single
        picker.register(UINib(nibName: "SCPickerViewTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
        picker.completion = { (selectedIndexes) in
            for index in selectedIndexes {
                guard let itemType = itemTypes?[index] else {
                    return
                }
                self.loadEquipmentItems(itemType: itemType)
            }
        }
        picker.show()
    }
}

// MARK: - TCPickerView delegate methods
extension SCEquipmentViewController: TCPickerViewOutput,TCPickerViewThemeType {
    func pickerView(_ pickerView: TCPickerViewInput, didSelectRowAtIndex index: Int) {
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
    func pickerView(_ pickerView: TCPickerViewInput,
                    cellForRowAt indexPath: IndexPath) -> (UITableViewCell & TCPickerCellType)? {
        let cell = pickerView.dequeue(withIdentifier: "ExampleTableViewCell", for: indexPath) as! SCPickerViewTableViewCell
        cell.titleLabel?.textColor = self.theme.textColor
        cell.checkmarkImageView?.image = UIImage(named: "checkmark_icon")?.withRenderingMode(.alwaysTemplate)
        cell.checkmarkImageView?.tintColor = self.theme.textColor
        cell.backgroundColor = self.theme.mainColor
        return cell
    }
}

private extension SCEquipmentViewController{
    func loadEquipmentItems(itemType: SCItemCommonTypes){
        guard let categoryType = itemType.items else{
            return
        }
        SVProgressHUD.show()
        viewModel?.loadEquipmentType(typeIndexGroup: categoryType, completion: { [weak self](items, isSuccess) in
            self?.selectedItems = items
            self?.showItemSelectionView()
            SVProgressHUD.dismiss()
        })
    }
}

extension SCEquipmentViewController: SCItemSelectionViewDelegate{
    func didSelectItem(index: Int) {
        for btn in equipmentButtons{
            if btn.tag == pressedButtonTag{
                btn.setButtonContent(item: selectedItems?[index])
                calculateDpsAndArmorValues()
                break
            }
        }
    }
    
    func didClickCloseButton(view: SCItemSelectionView) {
        hideItemSelectionView()
    }
}

private extension SCEquipmentViewController{
    func calculateDpsAndArmorValues(){
        var dpsTotal: Double = 0
        var minArmorTotal: Double = 0
        var maxArmorTotal: Double = 0
        for btn in equipmentButtons{
            dpsTotal += btn.dps
            minArmorTotal += btn.minArmor
            maxArmorTotal += btn.maxArmor
        }
        dpsLabel.text = "DPS: \(dpsTotal)"
        armorLabel.text = "ARMOR: \(minArmorTotal) - \(maxArmorTotal)"
    }
}

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
private let reuseIdentifier = "cell_id"
class SCEquipmentViewController: UIViewController {
    private let theme = TCPickerViewDarkTheme()
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
    }
    
    @IBAction func clickEquipmentButton(_ sender: UIButton) {
        var titles = [String]()
        switch sender.tag{
        case 101:
            for head in viewModel?.heads ?? []{
                titles.append(head.itemType)
            }
            showTypeSelectionView(title: "Heads", items: titles, itemTypes: viewModel?.heads)
        case 102:
            for shoulder in viewModel?.shoulders ?? []{
                titles.append(shoulder.itemType)
            }
            showTypeSelectionView(title: "Shoulders", items: titles, itemTypes: viewModel?.shoulders)
        case 103:
            for amulet in viewModel?.amulets ?? []{
                titles.append(amulet.itemType)
            }
            showTypeSelectionView(title: "Amulets", items: titles, itemTypes: viewModel?.amulets)
        case 104:
            for torso in viewModel?.torsos ?? []{
                titles.append(torso.itemType)
            }
            showTypeSelectionView(title: "Torsos", items: titles, itemTypes: viewModel?.torsos)
        case 105:
            for hand in viewModel?.hands ?? []{
                titles.append(hand.itemType)
            }
            showTypeSelectionView(title: "Hands", items: titles, itemTypes: viewModel?.hands)
        case 106:
            for wrist in viewModel?.wrists ?? []{
                titles.append(wrist.itemType)
            }
            showTypeSelectionView(title: "Wrists", items: titles, itemTypes: viewModel?.wrists)
        case 107:
            for waist in viewModel?.waists ?? []{
                titles.append(waist.itemType)
            }
            showTypeSelectionView(title: "Waists", items: titles, itemTypes: viewModel?.waists)
        case 108, 109:
            for ring in viewModel?.rings ?? []{
                titles.append(ring.itemType)
            }
            showTypeSelectionView(title: "Rings", items: titles, itemTypes: viewModel?.rings)
        case 110:
            for leg in viewModel?.legs ?? []{
                titles.append(leg.itemType)
            }
            showTypeSelectionView(title: "Legs", items: titles, itemTypes: viewModel?.legs)
        case 111:
            for weapon in viewModel?.weapons ?? []{
                titles.append(weapon.itemType)
            }
            showTypeSelectionView(title: "Weapons", items: titles, itemTypes: viewModel?.weapons)
        case 112:
            for offHand in viewModel?.offHands ?? []{
                titles.append(offHand.itemType)
            }
            showTypeSelectionView(title: "OffHands", items: titles, itemTypes: viewModel?.offHands)
        case 113:
            for foot in viewModel?.feet ?? []{
                titles.append(foot.itemType)
            }
            showTypeSelectionView(title: "Feet", items: titles, itemTypes: viewModel?.feet)
        default:
            break
        }
    }
}
private extension SCEquipmentViewController{
    func setupUI(){
        guard let characterName = characterName else {
            return
        }
        equipmentImageView.image = UIImage(named: "\(characterName)_equip")
    }
}
private extension SCEquipmentViewController{
    func showTypeSelectionView(title: String, items: [String], itemTypes: [SCItemCommonTypes]?){
        var picker: TCPickerViewInput = TCPickerView()
        picker.title = title
        let itemName = items
        let values = itemName.map { TCPickerView.Value(title: $0) }
        picker.values = values
        picker.delegate = self
        picker.theme = theme
        picker.selection = .single
        picker.register(UINib(nibName: "SCPickerViewTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
        picker.completion = { (selectedIndexes) in
            for _ in selectedIndexes {
                print(itemTypes)
            }
        }
        picker.closeAction = {
            print("Handle close action here")
        }
        picker.show()
    }
}
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

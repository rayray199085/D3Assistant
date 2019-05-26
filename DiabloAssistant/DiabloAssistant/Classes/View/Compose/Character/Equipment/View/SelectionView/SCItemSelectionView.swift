//
//  SCItemSelectionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 25/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCItemSelectionViewDelegate: NSObjectProtocol {
    func didClickCloseButton(view: SCItemSelectionView)
    func didSelectItem(index: Int)
}
private let reuseIdentifier = "collection_cell_id"
class SCItemSelectionView: UIView {
    weak var delegate: SCItemSelectionViewDelegate?
    var isWeaponType: Bool = false{
        didSet{
            requiredHand.isHidden = !isWeaponType
        }
    }
    
    @IBOutlet weak var requiredHand: UILabel!
    @IBOutlet weak var requiredLevel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    // for detecting collectionView scrolling
    private var previousContentOffsetX: CGFloat = 0
    var items: [SCEquipmentItem]?
    
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        textView.delegate = self
        collectionView.register(SCCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    @IBAction func clickCloseSelectionViewButton(_ sender: Any) {
        delegate?.didClickCloseButton(view: self)
        clearAllDescription()
        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    func reloadCollectionViewData(){
        collectionView.reloadData()
    }
    func clearAllDescription(){
        textView.attributedText = NSAttributedString(string: "")
        requiredLevel.text = ""
        requiredHand.text = ""
    }
}
extension SCItemSelectionView: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SCCollectionViewCell
        cell.item = items?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SCCollectionViewCell
        cell.didSelected()
        setupTextViewContent(index: indexPath.item)
        delegate?.didSelectItem(index: indexPath.item)
    }
}

private extension SCItemSelectionView{
    func setupTextViewContent(index: Int){
        if index >= (items?.count ?? 0){
            return
        }
        guard let selectedItem = items?[index] else{
            return
        }
        textView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        textView.attributedText = NSAttributedString.getItemDescriptionAttributedText(details: selectedItem.details)
        setupLevelAndHandLabel(selectedItem: selectedItem)
    }
    func setupLevelAndHandLabel(selectedItem: SCEquipmentItem){
        requiredLevel.text = "Required level: \(selectedItem.details?.requiredLevel ?? 1)"
        requiredHand.text = selectedItem.details?.type?.twoHanded == 0 ? "1-Hand" : "2-Hand"
    }
}
extension SCItemSelectionView: UITextViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if abs(scrollView.contentOffset.x - previousContentOffsetX) > 0 {
            if textView.attributedText.length > 0{
                clearAllDescription()
            }
        }
    }
}

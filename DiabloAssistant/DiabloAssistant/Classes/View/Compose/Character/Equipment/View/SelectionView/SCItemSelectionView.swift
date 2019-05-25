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
}
private let reuseIdentifier = "collection_cell_id"
class SCItemSelectionView: UIView {
    weak var delegate: SCItemSelectionViewDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [SCEquipmentItem]?
    
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SCCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    @IBAction func clickCloseSelectionViewButton(_ sender: Any) {
        delegate?.didClickCloseButton(view: self)
    }
    
    func reloadCollectionViewData(){
        collectionView.reloadData()
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
        print(indexPath.item)
    }
}

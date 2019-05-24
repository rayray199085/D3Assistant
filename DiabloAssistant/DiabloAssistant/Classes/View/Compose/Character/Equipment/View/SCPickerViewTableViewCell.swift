//
//  SCPickerViewTableViewCell.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 24/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import TCPickerView

class SCPickerViewTableViewCell: UITableViewCell, TCPickerCellType {
    var viewModel: TCPickerModel? {
        didSet {
            self.updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var checkmarkImageView: UIImageView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .clear
        self.selectionStyle = .none
    }
    
    func updateUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        self.titleLabel?.text = viewModel.title
        self.checkmarkImageView?.isHidden = !viewModel.isChecked
    }
}

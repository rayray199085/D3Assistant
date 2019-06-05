//
//  SCProfileRecordCell.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 5/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileRecordCell: UITableViewCell {
    var record: SCProfileInputRecord?{
        didSet{
            battleTagLabel.text = record?.battleTag
            regionLabel.text = record?.region
        }
    }
    
    @IBOutlet weak var battleTagLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

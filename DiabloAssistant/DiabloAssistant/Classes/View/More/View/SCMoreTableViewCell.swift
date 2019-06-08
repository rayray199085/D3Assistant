//
//  SCMoreTableViewCell.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 8/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCMoreTableViewCell: UITableViewCell {
    var iconName: String?{
        didSet{
            guard let iconName = iconName else{
                return
            }
            iconImageView.image = UIImage(named: iconName)
        }
    }
    var titleText: String?{
        didSet{
            cellTitleLabel.text = titleText
        }
    }
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

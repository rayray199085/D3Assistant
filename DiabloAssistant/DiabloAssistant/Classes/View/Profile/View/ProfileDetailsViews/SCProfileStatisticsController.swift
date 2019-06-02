//
//  SCProfileStatisticsController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileStatisticsController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var basicInfoLabel: UILabel!
    var viewModel: SCProfileViewModel?{
        didSet{
            guard let text = viewModel?.heroStatsDescription else{
                return
            }
            textView.text = text
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    func setBasicInfoContent(content: String){
        basicInfoLabel.text = content
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

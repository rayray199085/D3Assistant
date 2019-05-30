//
//  SCProfileRecordView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 30/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileRecordView: UIView {
    var profileData: SCProfileData?{
        didSet{
            if let profileData = profileData,
                let heroes = profileData.heroes{
                setupUI(count: heroes.count)
                for (index,hero) in heroes.enumerated(){
                    (buttonsView.subviews[index] as! SCProfileButton).hero = hero
                }
                recordCountLabel.text = "Total: \(heroes.count)"
                lastUpdatedLabel.isHidden = false
                battleTagLabel.text = profileData.battleTag
                lastUpdatedLabel.text = profileData.recentUpdatedTime
            }
        }
    }
    
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var battleTagLabel: UILabel!
    @IBOutlet weak var recordCountLabel: UILabel!
    @IBOutlet weak var buttonsView: UIScrollView!
    class func recordView()->SCProfileRecordView{
        let nib = UINib(nibName: "SCProfileRecordView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCProfileRecordView
        v.frame = UIScreen.main.bounds
        return v
    }
}
extension SCProfileRecordView{
    func setupUI(count: Int){
        // clear previous data
        for v in buttonsView.subviews{
            v.removeFromSuperview()
        }
        let margin:CGFloat = 5
        let verticalMargin:CGFloat = 0
        let width: CGFloat = 106
        let horizontalMargin = (UIScreen.screenWidth() - width * 3 - margin * 2) / 2
        for i in 0..<count{
            let v = SCProfileButton.profileButton()
            let x = horizontalMargin + CGFloat(i % 3) * (width + margin)
            let y = verticalMargin + CGFloat(i / 3) * (width + margin)
            v.frame = CGRect(x: x, y: y, width: width, height: width)
            buttonsView.addSubview(v)
        }
        buttonsView.contentSize = CGSize(width: 0, height: CGFloat(count / 3) * (width + margin) + width - margin)
    }
}

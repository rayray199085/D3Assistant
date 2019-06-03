//
//  SCProfileStatisticsController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCProfileStatisticsController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var basicInfoLabel: UILabel!
    @IBOutlet weak var legendaryPowerView: UIView!
    private let detailsView = SCProfileEquipmentDetailsView.detailsView()
    
    var viewModel: SCProfileViewModel?{
        didSet{
            guard let text = viewModel?.heroStatsDescription else{
                return
            }
            textView.text = text
            guard let powers = viewModel?.legendaryPowers else{
                return
            }
            for (index,power) in powers.enumerated(){
                (legendaryPowerView.subviews[index] as! SCProfilePowerView).power = power
            }
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
        setupUI()
    }

}
private extension SCProfileStatisticsController{
    func setupUI(){
        setupPowerView()
        setupDetailsView()
    }
    func setupPowerView(){
        let width: CGFloat = 115
        let margin = (UIScreen.main.bounds.width - width * 3) / 4
        for i in 0..<3{
            let x = CGFloat(i % 3) * (margin + width) + margin
            let v = SCProfilePowerView.powerView()
            v.frame.origin = CGPoint(x: x, y: 0)
            v.setEquipBackgroundImage(index: i)
            v.delegate = self
            legendaryPowerView.addSubview(v)
        }
    }
    func setupDetailsView(){
        navigationController?.view.addSubview(detailsView)
        detailsView.isHidden = true
        detailsView.delegate = self
    }
}
extension SCProfileStatisticsController: SCProfileEquipmentDetailsViewDelegate{
    func dismissDetailsView() {
        detailsView.isHidden = true
    }
}
extension SCProfileStatisticsController: SCProfilePowerViewDelegate{
    func didClickEquipButton(powerView: SCProfilePowerView, slugId: String) {
        SVProgressHUD.show()
        viewModel?.loadEquipmentDetails(slugId: slugId, completion: { [weak self] (details, isSuccess) in
            self?.detailsView.details = details
            self?.detailsView.isHidden = false
            SVProgressHUD.dismiss()
        })
        
    }
}

//
//  SCProfileEquipmentController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCProfileEquipmentController: UIViewController {
    private lazy var detailsView = SCProfileHeroEquipDetailsView.detailsView()
    
    var viewModel: SCProfileViewModel?{
        didSet{
            if viewModel?.heroEquips != nil{
                return 
            }
            SVProgressHUD.show()
            viewModel?.loadEquipmentItems(completion: { [weak self](isSuccess) in
                self?.setEquipmentButtonImages()
                SVProgressHUD.dismiss()
            })
        }
    }
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet var equipmentButtons: [SCProfileEquipButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.view.addSubview(detailsView)
        detailsView.isHidden = true
        detailsView.delegate = self
    }
    deinit {
        // clear current hero info
        viewModel?.heroEquips = nil
    }
    
    func setBackgroundImage(imageName: String){
        bgImageView.image = UIImage(named: imageName)
    }
    
    @IBAction func clickEquipmentButton(_ sender: SCProfileEquipButton) {
        detailsView.isHidden = false
        detailsView.item = sender.item
    }
}
private extension SCProfileEquipmentController{
    func setEquipmentButtonImages(){
        for (index,btn) in equipmentButtons.enumerated(){
            btn.item = viewModel?.heroEquips?.items?[index]
        }
        setButtonGemView()
    }
    func setButtonGemView(){
        for (index,btn) in equipmentButtons.enumerated(){
            guard let gems = btn.item?.gems else{
                continue
            }
            for (i,gem) in gems.enumerated(){
                let gemView = SCProfileEquipGemView.gemView(index: index)
                gemView.delegate = self
                gemView.setGemImage(image: gem.item?.iconImage)
                gemView.center = CGPoint(x: btn.center.x, y: btn.frame.minY + CGFloat(i + 1) / CGFloat(gems.count + 1) * btn.bounds.height)
                view.addSubview(gemView)
            }
        }
    }
}
extension SCProfileEquipmentController: SCProfileEquipGemViewDelegate{
    func didClickGemButton(view: SCProfileEquipGemView, index: Int) {
        clickEquipmentButton(equipmentButtons[index])
    }
}
extension SCProfileEquipmentController: SCProfileHeroEquipDetailsViewDelegate{
    func didClickEquipMaskButton(view: SCProfileHeroEquipDetailsView) {
        detailsView.isHidden = true
    }
}

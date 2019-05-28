//
//  SCItemsViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCFollowerViewController: SCBaseViewController{
    private lazy var followerContentView = SCFollowerContentView.contentView()
    private lazy var viewModel: SCFollowerViewModel = SCFollowerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadData() {
       
    }
    override func setupUserView() {
        super.setupUserView()
        setupUI()
    }
}
private extension SCFollowerViewController{
    func setupUI(){
        view.addSubview(followerContentView)
        followerContentView.viewModel = viewModel
    }
}


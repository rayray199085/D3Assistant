//
//  SCProfileViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell_id"
class SCProfileViewController: SCBaseViewController {
    private var tableView: UITableView?
    private lazy var profiles = [SCProfileInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadData() {
        
    }
    override func setupUserView() {
        super.setupUserView()
        setupUI()
    }
    @objc private func addNewProfile(){
        print("add")
    }
}
private extension SCProfileViewController{
    func setupUI(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewProfile))
        navigationController?.navigationBar.tintColor = SCButtonTitleColor
        tableView = UITableView(frame: view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

//
//  SCBaseViewController.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import DropDown

class SCBaseViewController: UIViewController {
    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    var isPullUp = false
    var visitorInfo : [String : String]?
    private lazy var userDefault = UserDefaults.standard
    private lazy var dropDown = DropDown()
    private var regionName = "us"
    private var selectedRegion = "🇺🇸US"{
        didSet{
            switch selectedRegion {
            case "🇺🇸US":
                regionName = "us"
            case "🇪🇺EU":
                regionName = "eu"
            case "🇦🇺APAC":
                regionName = "apac"
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SCNetworkManager.shared.userLogon ? loadData() :()
        NotificationCenter.default.addObserver(self, selector: #selector(successLogin), name: NSNotification.Name(SCUserSuccessLoginNotification), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(SCUserSuccessLoginNotification), object: self)
    }
    @objc func loadData(){
        refreshControl?.endRefreshing()
    }
    @objc private func region(){
        dropDown.show()
    }
}
extension SCBaseViewController{
    
    @objc private func login(){
        NotificationCenter.default.post(name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
    }

    @objc private func successLogin(){
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        view = nil
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(SCUserSuccessLoginNotification), object: nil)
    }
}

// MARK: - setup UI
extension SCBaseViewController{
    @objc private func setupUI(){
        //        view.backgroundColor = UIColor.orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SCButtonTitleColor]
        SCNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    @objc func setupTableView(){
        tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        guard let tableView = tableView,
            let naviBar = navigationController?.navigationBar else {
                return
        }
        view.insertSubview(tableView, belowSubview: naviBar)
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
    }
    
    private func setupVisitorView(){
        let visitiorView = SCVisitorView(frame: view.bounds)
        guard let naviBar = navigationController?.navigationBar else {
            return
        }
        view.insertSubview(visitiorView, belowSubview: naviBar)
        naviBar.tintColor = SCButtonTitleColor
        let loginBarButtonItem = UIBarButtonItem(title: "Login", style: UIBarButtonItem.Style.plain, target: self, action: #selector(login))
      
        let regionBarButtonItem = UIBarButtonItem(title: "🇺🇸US", target: self, action: #selector(region))//UIBarButtonItem(title: "🇺🇸US", style: UIBarButtonItem.Style.plain, target: self, action: #selector(region))
        navigationItem.rightBarButtonItem = loginBarButtonItem
        navigationItem.leftBarButtonItem = regionBarButtonItem
        // init region value is us
        userDefault.set(regionName, forKey: "region")
        dropDown.anchorView = regionBarButtonItem
        dropDown.dataSource = ["🇺🇸US", "🇪🇺EU", "🇦🇺APAC"]
        dropDown.width = 100
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            guard let btn = regionBarButtonItem.customView as? UIButton else{
                return
            }
            self.selectedRegion = item
            self.userDefault.set(self.regionName, forKey: "region")
            btn.setTitle(item, for: [])
            btn.sizeToFit()
            
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SCBaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        let currentSection = indexPath.section
        let lastSection = tableView.numberOfSections - 1
        if currentSection == lastSection && (currentRow == tableView.numberOfRows(inSection: lastSection) - 1) && !isPullUp {
            isPullUp = true
            loadData()
        }
    }
}

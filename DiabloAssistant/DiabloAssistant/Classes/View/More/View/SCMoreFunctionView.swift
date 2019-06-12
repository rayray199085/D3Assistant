//
//  SCMoreFunctionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 8/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell_id"
protocol SCMoreFunctionViewDelegate: NSObjectProtocol{
    func didClickTableViewCell(view: SCMoreFunctionView, row: Int,title: String?, content: String?)
}
class SCMoreFunctionView: UIView {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SCMoreFunctionViewDelegate?
    
    private let titleInfoArray = [
        ["title": "Rate us on the App Store", "iconName": "more_rate","content":"We'd love to hear your feedback, whether you've got ideas on how we can improve - and would really appreciate it if you rate us on the App Store."],
        ["title": "Contact us", "iconName": "more_email","content":"You can email us if you have any comments, suggestions or even ideas.\nYour opinion is very important to us."],
        ["title": "Fork us on GitHub", "iconName": "more_fork", "content":"This is a free and open source application.\n\nIf you are interested in this app and want to make it become better, contact us to know more."],
        ["title": "About", "iconName": "more_about", "content": "Produced by: Rui Cao\n\nVersion: v1.0.1\n\nCopyright © 2019 Rui Cao. All rights reserved."]]
    
    class func functionView()->SCMoreFunctionView{
        let nib = UINib(nibName: "SCMoreFunctionView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCMoreFunctionView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        setupUI()
    }
}
extension SCMoreFunctionView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCMoreTableViewCell
        cell.iconName = titleInfoArray[indexPath.row]["iconName"]
        cell.titleText = titleInfoArray[indexPath.row]["title"]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didClickTableViewCell(view: self, row: indexPath.row, title: titleInfoArray[indexPath.row]["title"], content: titleInfoArray[indexPath.row]["content"])
    }
}

private extension SCMoreFunctionView{
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SCMoreTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}

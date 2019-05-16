//
//  SCOAuthViewController.swift
//  WowLittleHelper
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SCOAuthViewController: UIViewController {
    private lazy var webView = WKWebView(frame: UIScreen.main.bounds)
    
    override func loadView() {
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupWebView()
    }
    
    @objc private func goBack(){
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
}
private extension SCOAuthViewController{
    func setupUI(){
     navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(goBack), isBack: true)
    }
    func setupWebView(){
        guard let region = UserDefaults.standard.object(forKey: "region") as? String else{
            return
        }
        let urlString = "https://\(region).battle.net/oauth/authorize?access_type=online&client_id=\(SCClientId)&redirect_uri=\(SCRedirectURL)&response_type=code"
        guard let url = URL(string: urlString) else{
            return
        }
        webView.load(URLRequest(url: url))
    }
}
extension SCOAuthViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString.hasPrefix(SCRedirectURL) == false {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        if navigationAction.request.url?.query?.hasPrefix("code=") == false{
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        let code = ((navigationAction.request.url?.query)! as NSString).substring(from: "code=".count)
        SCNetworkManager.shared.getAccessToken(code: code) { (isSuccess) in
            if !isSuccess{
                SVProgressHUD.showInfo(withStatus: "Fail to login.")
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(SCUserSuccessLoginNotification), object: nil)
                self.goBack()
            }
        }
        decisionHandler(WKNavigationActionPolicy.cancel)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}

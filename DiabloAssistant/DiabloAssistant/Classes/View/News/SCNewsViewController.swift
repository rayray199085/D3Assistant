//
//  SCNewsViewController.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 16/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SCNewsViewController: UIViewController {
    private lazy var webView = WKWebView(frame: UIScreen.main.bounds)
    override func loadView() {
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }
}
private extension SCNewsViewController{
    func setupUI(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : SCButtonTitleColor]
    }
    func loadWebView(){
        let urlString = "https://news.blizzard.com/en-us/diablo3"
        guard let url = URL(string: urlString) else{
            return
        }
        webView.load(URLRequest(url: url))
    }
}
extension SCNewsViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}

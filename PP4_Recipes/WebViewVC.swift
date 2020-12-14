//
//  WebViewVC.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/13/20.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {

    //var url:URL?
    var webview:WKWebView!
    var data:RecData?
    
    override func loadView() {
        webview=WKWebView()
        webview.navigationDelegate=self
        view=webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmpUString=data?.rUrl
        let url=URL(string: tmpUString!)
        webview.load(URLRequest(url: url!))
        webview.allowsBackForwardNavigationGestures = true
    }

}

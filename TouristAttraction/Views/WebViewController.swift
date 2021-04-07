//
//  WebViewController.swift
//  TouristAttraction
//
//  Created by Mohit Sharma on 07/04/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var url:String = ""
    let webView = WKWebView()
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         webView.navigationDelegate = self
        let address = URL(string:self.url)!
        webView.load(URLRequest(url: address))
    }
}

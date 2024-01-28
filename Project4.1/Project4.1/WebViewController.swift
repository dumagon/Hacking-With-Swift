//
//  WebViewController.swift
//  Project4.1
//
//  Created by Zach Nazarov on 20/12/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate{
    
    var webView: WKWebView!
    var url: URL?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlToLoad = url {
            webView.load(URLRequest(url:urlToLoad))
            title = urlToLoad.host
        }
     

        // Do any additional setup after loading the view.
    }
    


}

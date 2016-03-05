//
//  FacebookViewController.swift
//  SocialSelf
//
//  Created by Harry Liu on 2016-03-05.
//  Copyright © 2016 SocialSelf. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: ViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: NSURL!
    
    override func viewDidLoad() {
        
    }
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
}
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
    var id: String?
    
    override func viewDidLoad() {
        print("Facebook")
        facebook()
    }
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    func facebook() {
        if (id != nil) {
            let url = NSURL(string: "https://www.facebook.com/addfriend.php?id=" + id!)!
            
            webView.loadRequest(NSURLRequest(URL: url))
            webView.allowsBackForwardNavigationGestures = false
        }
        else {
            print("id is null")
        }
    }
}
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        webView = WKWebView()
        view = webView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
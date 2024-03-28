//
//  NewsWebsite.swift
//  News
//
//  Created by Mahmud CIKRIK on 28.03.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView
    
    init(webView: WKWebView) {
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = view.bounds
    }
    
    deinit {
        print("Web Page Deinitalized")
    }
    
}

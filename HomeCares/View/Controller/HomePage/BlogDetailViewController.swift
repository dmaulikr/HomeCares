//
//  BlogDetailViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import SpringIndicator

class BlogDetailViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var webview: UIWebView!
    internal var blog: Blog!
    internal var indicator: SpringIndicator!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    
    // MARK: Internal method
    
    internal func startLoading() {
        indicator = SpringIndicator()
        indicator.lineColor = UIColor.primary
        indicator.lineWidth = 2
        
        webview.layout(indicator)
                .centerVertically()
                .centerHorizontally()
                .size(CGSize(width: 36, height: 36))
        indicator.startAnimation()
    }
    
    internal func stopLoading() {
        if indicator != nil, indicator.isSpinning() {
            indicator.stopAnimation(false)
        }
    }
    
    
    internal func prepareUI() {
        startLoading()
        webview.delegate = self
        webview.loadHTMLString(blog.content, baseURL: nil)
    }
}


extension BlogDetailViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        stopLoading()
    }
}

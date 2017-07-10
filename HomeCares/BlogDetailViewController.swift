//
//  BlogDetailViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class BlogDetailViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var webview: UIWebView!
    internal var blog: Blog!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        webview.loadHTMLString(blog.content, baseURL: nil)
    }
}

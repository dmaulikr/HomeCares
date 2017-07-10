//
//  AppSearchBarViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class AppSearchBarController: SearchBarController {
    fileprivate var menuButton: IconButton!
    fileprivate var moreButton: IconButton!
    
    open override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareMoreButton()
        prepareStatusBar()
        prepareSearchBar()
    }
}

extension AppSearchBarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
    }
    
    fileprivate func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreVertical)
    }
    
    fileprivate func prepareStatusBar() {
        statusBarStyle = .lightContent
        
        // Access the statusBar.
        //        statusBar.backgroundColor = Color.grey.base
    }
    
    fileprivate func prepareSearchBar() {
        searchBar.leftViews = [menuButton]
        searchBar.rightViews = [moreButton]
    }
}

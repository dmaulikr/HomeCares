//
//  HomeCareNavigationController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class HomeCareNavigationController: UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationAppearence()
    }
    
    fileprivate func setupNavigationAppearence() {
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.primary
    }
}

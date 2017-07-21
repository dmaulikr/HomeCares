//
//  HomeCareTabbar.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class HomeCareTabbarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.primary
        selectedIndex = 2
    }
}

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
//        let medicalReportBookViewController = UIStoryboard.init(name: "MedicalReport", bundle: nil).instantiateViewController(withIdentifier: "MedicalReportBookViewController")
//        let questionAnswerViewController = UIStoryboard.init(name: "QuestionAnswer", bundle: nil).instantiateViewController(withIdentifier: "QuestionAnswerViewController")
//        let serviceViewController = UIStoryboard.init(name: "Service", bundle: nil).instantiateViewController(withIdentifier: "ServiceViewController")
//        let homePageViewController = UIStoryboard.init(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "HomePageViewController")
//        let moreViewController = UIStoryboard.init(name: "More", bundle: nil).instantiateViewController(withIdentifier: "MoreViewController")
//        setViewControllers([HomeCareNavigationController(rootViewController: AppFABMenuViewController(rootViewController: medicalReportBookViewController)),
//                            HomeCareNavigationController(rootViewController: serviceViewController),
//                            HomeCareNavigationController(rootViewController: homePageViewController),
//                            HomeCareNavigationController(rootViewController: questionAnswerViewController),
//                            HomeCareNavigationController(rootViewController: moreViewController)], animated: true)
    }
}

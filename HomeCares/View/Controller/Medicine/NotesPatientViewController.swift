//
//  NotesPatientViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/18/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NotesPatientViewController: UIViewController {

    // MARK: Property 
    
    internal var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension NotesPatientViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Sổ y bạ")
    }
}

//
//  PatientTabbarViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/17/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class MedicineDetailViewController: TwitterPagerTabStripViewController {
    
    internal var medicine: Medicine!
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs = [UIViewController]()
        let vc1 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "NAME"))
        vc1.content = medicine.name
        let vc2 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "GROUP"))
        vc2.content = medicine.medicineGroups.groupName
        let vc3 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "IMFORMATION"))
        vc3.content = medicine.informations
        let vc4 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "CONTRAINDICATION"))
        vc4.content = medicine.contraindication
        let vc5 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "SIDE EFFECTS"))
        vc5.content = medicine.sideEffects
        let vc6 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "INTERACTION"))
        vc6.content = medicine.interaction
        vcs.append(contentsOf: [vc1,vc2,vc3,vc4,vc5,vc6])
        if !medicine.companyRegister.isEmpty {
            let vc7 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "COMPANY"))
            vc7.content = medicine.companyRegister
            vcs.append(vc7)
        }
        if !medicine.countryRegister.isEmpty {
            let vc8 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "COUNTRY"))
            vc8.content = medicine.countryRegister
            vcs.append(vc8)
        }
        let vc9 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "OVERDOSE"))
        vc9.content = medicine.overdose
        vcs.append(vc9)
        if !medicine.longevity.isEmpty {
            let vc10 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "LONGEVITY"))
            vc10.content = medicine.longevity
             vcs.append(vc10)
        }
        let vc11 = MedicineItemViewController(itemInfo: IndicatorInfo(title: "PRESERVATION"))
        vc11.content = medicine.preservation
        vcs.append(vc11)
        return vcs
    }
    
    
}

 

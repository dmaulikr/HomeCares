//
//  DiseaseDetailViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/21/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

import UIKit
import XLPagerTabStrip

class DiseaseDetailViewController: TwitterPagerTabStripViewController {
    
    internal var disease: Disease!
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs = [UIViewController]()
        if !disease.summary.isEmpty {
            let vc1 = DiseaseItemViewController(itemInfo: IndicatorInfo(title: "SUMMARY"))
            vc1.content = disease.summary.trimmed.replacingOccurrences(of: "\n", with: "")
            vcs.append(vc1)
        }
        if !disease.overview.isEmpty {
            let vc2 = DiseaseItemViewController(itemInfo: IndicatorInfo(title: "OVERVIEW"))
            vc2.content = disease.overview.trimmed.replacingOccurrences(of: "\n", with: "")
            vcs.append(vc2)
        }
        if !disease.cause.isEmpty {
            let vc3 = DiseaseItemViewController(itemInfo: IndicatorInfo(title: "CAUSE"))
            vc3.content = disease.cause.trimmed.replacingOccurrences(of: "\n", with: "")
            vcs.append(vc3)
        }
        if !disease.precaution.isEmpty {
            let vc4 = DiseaseItemViewController(itemInfo: IndicatorInfo(title: "PRECAUTION"))
            vc4.content = disease.precaution.trimmed.replacingOccurrences(of: "\n", with: "")
            vcs.append(vc4)
        }
        if !disease.treatment.isEmpty {
            let vc5 = DiseaseItemViewController(itemInfo: IndicatorInfo(title: "TREATMENT"))
            vc5.content = disease.treatment.trimmed.replacingOccurrences(of: "\n", with: "")
            vcs.append(vc5)
        }
        return vcs
    }
    
    
}

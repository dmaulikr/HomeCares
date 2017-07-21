//
//  MedicineItemViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/17/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MedicineItemViewController: UIViewController, IndicatorInfoProvider {
    
    internal var itemInfo: IndicatorInfo = "View"
    internal var content: String = ""
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name:"Montserrat-Light", size:15)
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.textColor = UIColor.black
        textView.showsVerticalScrollIndicator = false
        view.addSubview(textView)
        view.backgroundColor = .white
        textView.text = content
        view.addConstraint(NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10))
         view.addConstraint(NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10))
    }
    
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

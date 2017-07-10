//
//  String+Extension.swift
//  View
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

extension String {
    
    internal var nib: UINib {
        return UINib(nibName: self, bundle: Bundle.workRoster)
    }
    
    internal var image: UIImage? {
        return UIImage(named: self, in: Bundle.workRoster, compatibleWith: nil)
    }
    
}

extension String {
    
    public func date(format: DateFormat) -> String? {
        let date = DateHelper.shared.date(from: self, format: DateFormat.yyyy_MM_dd_T_HH_mm_ss_Z , timeZone: "LOCAL")
        if let date = date{
            return DateHelper.shared.string(from: date, format: format , timeZone: "LOCAL")
        }
        return nil
    }

}

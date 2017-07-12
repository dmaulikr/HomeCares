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
    
    public var timeInterval: String {
        if let createdTime = DateHelper.shared.date(from: self, format: .yyyy_MM_dd_T_HH_mm_ss_Z) {
            var t = Date().timeIntervalSince(createdTime)
            var time = Int(t)
            if time < 60 {
                return "\(time) giây trước"
            }
            time = Int(t / 60)
            if time < 60 {
                return "\(time) phút trước"
            }
            time = Int(t / 3600)
    
            if time < 24 {
                return "\(time) giờ trước"
            }
            time = Int(t / (3600 * 24))
            
            if time < 30 {
                return "\(time) ngày trước"
            }
            time = Int(t / (3600 * 24 * 30))
            if time < 12 {
                return "\(time) tháng trước"
            }
            time = Int(t / (3600 * 24 * 30 * 12))
            return "\(time) năm trước"
        }
        return ""
    }

}

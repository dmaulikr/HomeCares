//
//  DateHelper.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit

public struct DateFormat {
    
    public var name: String
    
    public init(_ name: String) {
        self.name = name
    }
    
}

extension DateFormat {
    
    public static let yyyy_MM_dd = DateFormat("yyyy-MM-dd")
    public static let HH_mm_ss_EEE_dd_LLL_yyyy = DateFormat("HH:mm:ss EEE dd LLL yyyy")
    public static let yyyy_MM_dd_T_HH_mm_ss_Z = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
    public static let MMM_dd_yyyy_HH_mm_aa = DateFormat("MMM dd, yyyy hh:mm aa")
    public static let MMM_dd_yyyy = DateFormat("MMM dd, yyyy")
    public static let hh_mm_aa = DateFormat("hh:mm aa")
    public static let dd_MM_yyyy = DateFormat("MM/dd/yyyy")
    public static let HH_mm_dd_MM_yyyy = DateFormat("HH:mm - dd/MM/yyyy")
}

public class DateHelper {
    
    // MARK: Property
    
    public static let shared = DateHelper()
    
    private var formatters = [String: DateFormatter]()
    
    // MARK: Constructor
    
    private init() {
        
    }
    
    // MARK: Public method
    
    public func date(from dateString: String, format: DateFormat, timeZone: String = "LOCAL") -> Date? {
        return formatter(format: format, timeZone: timeZone).date(from: dateString)
    }
    
    public func string(from date: Date, format: DateFormat, timeZone: String = "LOCAL") -> String {
        return formatter(format: format, timeZone: timeZone).string(from: date)
    }
    
    // MARK: Private method
    
    private func formatter(format: DateFormat, timeZone: String = "LOCAL") -> DateFormatter {
        var formatter = formatters[format.name]
        if formatter == nil {
            formatter = DateFormatter()
            formatter!.dateFormat = format.name
            formatters[format.name] = formatter
        }
        if timeZone == "LOCAL" {
            formatter!.timeZone = TimeZone.current
        } else {
            formatter!.timeZone = TimeZone(abbreviation: timeZone)
        }
        return formatter!
    }
    
}


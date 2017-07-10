//
//  Date+Extension.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

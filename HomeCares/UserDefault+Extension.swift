//
//  UserDefault+Extension.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/11/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    
    public static var userId: Int? {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.integer(forKey: "userId")
        }
        set {
            let userDefaults = UserDefaults.standard
            if let hasValue = newValue {
                userDefaults.set(hasValue, forKey: "userId")
            } else {
                userDefaults.removeObject(forKey: "userId")
            }
            userDefaults.synchronize()
        }
    }
    
    public static var avatar: String? {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.string(forKey: "avatar")
        }
        set {
            let userDefaults = UserDefaults.standard
            if let hasValue = newValue {
                userDefaults.set(hasValue, forKey: "avatar")
            } else {
                userDefaults.removeObject(forKey: "avatar")
            }
            userDefaults.synchronize()
        }
    }
    
    public static var nameUser: String? {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.string(forKey: "name")
        }
        set {
            let userDefaults = UserDefaults.standard
            if let hasValue = newValue {
                userDefaults.set(hasValue, forKey: "name")
            } else {
                userDefaults.removeObject(forKey: "name")
            }
            userDefaults.synchronize()
        }
    }

    
}

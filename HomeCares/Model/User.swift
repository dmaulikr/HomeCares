//
//  User.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject {
    
    // MARK: Property
    
    internal var userId: Int
    internal var userName: String
    internal var password: String
    internal var email: String
    internal var phone: String
    internal var userRole: Int
    internal var userState: Int
    internal var accountState: Int
    internal var wrongPasswordCount: Int
    internal var activeCode: Int
    internal var created: String
    internal var updated: String
    
    // MARK: Constructor
    
    public init(json: JSON) {
        userId = json["userId"].intValue
        userName = json["userName"].stringValue
        password = json["password"].stringValue
        email = json["email"].stringValue
        phone = json["phone"].stringValue
        userRole = json["userRole"].intValue
        userState = json["userState"].intValue
        accountState = json["accountState"].intValue
        wrongPasswordCount = json["wrongPasswordCount"].intValue
        activeCode = json["activeCode"].intValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
    }
    
}

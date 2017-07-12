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
    
    internal var id: Int
    internal var userName: String
    internal var passwordHash: String
    internal var email: String
    internal var phoneNumber: String
    internal var phoneNumberConfirmed: String!
    internal var userPerson: UserPerson!
    // MARK: Constructor
    
    public init(json: JSON) {
        id = json["id"].intValue
        userName = json["userName"].stringValue
        passwordHash = json["passwordHash"].stringValue
        email = json["email"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        phoneNumberConfirmed = json["phoneNumberConfirmed"].stringValue
        userPerson = UserPerson(json: JSON(json["userPerson"].object))
    }
}

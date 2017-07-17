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
    
    internal var id: Int!
    internal var userName: String!
    internal var passwordHash: String!
    internal var email: String!
    internal var phoneNumber: String!
    internal var phoneNumberConfirmed: Bool!
    internal var userPerson: UserPerson!
    internal var accessFailedCount: Int!
    internal var twoFactorEnabled: Bool!
    internal var emailConfirmed: Bool!
    
    // MARK: Constructor
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        id = json["id"].intValue
        accessFailedCount = json["accessFailedCount"].intValue
        userName = json["userName"].stringValue
        passwordHash = json["passwordHash"].stringValue
        email = json["email"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        phoneNumberConfirmed = json["phoneNumberConfirmed"].boolValue
        userPerson = UserPerson(json: JSON(json["userPerson"].object))
        twoFactorEnabled = json["twoFactorEnabled"].boolValue
        emailConfirmed = json["emailConfirmed"].boolValue
    }
    
    internal var parameters: [String: Any] {
        return ["userName":userName,
                "email": email,
                "phoneNumber":phoneNumber,
                "phoneNumberConfirmed":phoneNumberConfirmed,
                "accessFailedCount":accessFailedCount,
                "emailConfirmed":emailConfirmed,
                "passwordHash":passwordHash,
                "twoFactorEnabled":twoFactorEnabled,
                "userPerson": [
                    "firstName":userPerson.firstName,
                    "middleName":userPerson.middleName,
                    "lastName":userPerson.lastName,
                    "gender":userPerson.gender.rawValue,
                    "birthDay":userPerson.birthDay,
                    "created":userPerson.created,
                    "updated":userPerson.updated]
                ]
    }
}

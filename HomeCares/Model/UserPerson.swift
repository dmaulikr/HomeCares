//
//  UserPerson.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserPerson: NSObject {
    
    // MARK: Property
    
    internal var personId: Int!
    internal var userId: Int!
    internal var idCardNumber: String!
    internal var balances: Double!
    internal var firstName: String!
    internal var lastName: String!
    internal var middleName: String!
    internal var gender: Gender!
    internal var address: String!
    internal var avatar: String!
    internal var birthDay: String!
    internal var latitude: Double!
    internal var longitude: Double!
    internal var information: String!
    internal var created: String!
    internal var updated: String!
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        personId = json["personId"].intValue
        userId = json["userId"].intValue
        idCardNumber = json["idCardNumber"].stringValue
        balances = json["balances"].doubleValue
        firstName = json["firstName"].stringValue
        lastName = json["lastName"].stringValue
        middleName = json["middleName"].stringValue
        gender = Gender(rawValue: json["gender"].intValue)
        address = json["address"].stringValue
        avatar = "\(Configuration.BaseUrl)/\(json["avatar"].stringValue)"
        birthDay = json["birthDay"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        information = json["information"].stringValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
    }
    
}

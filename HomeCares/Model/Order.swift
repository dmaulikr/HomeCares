//
//  Order.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/15/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class Order: NSObject {
    
    // MARK: Property
    
    internal var orderId: Int!
    internal var price: Double!
    internal var phone: String!
    internal var email: String!
    internal var address: String!
    internal var information: String!
    internal var latitude: Double!
    internal var longitude: Double!
    internal var orderState: Int!
    internal var created: String!
    internal var updated: String!
    internal var personId: Int!
    internal var patientId: Int!
    internal var patient: Patient!
    internal var userPerson: UserPerson!
    internal var bookingTime: String!
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        orderId = json["orderId"].intValue
        price = json["price"].doubleValue
        phone = json["phone"].stringValue
        email = json["email"].stringValue
        address = json["address"].stringValue
        information = json["information"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        orderState = json["orderState"].intValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
        personId = json["personId"].intValue
        patientId = json["patientId"].intValue
        patient = Patient(json: JSON(json["patient"].object))
        userPerson = UserPerson(json: JSON(json["userPerson"].object))
        bookingTime = json["bookingTime"].stringValue
    }
    
    internal var parameters: [String: Any] {
        return ["phone":phone,
                "price":price,
                "email":email,
                "address":address,
                "information":information,
                "latitude":latitude,
                "longitude":longitude,
                "created":created,
                "updated":updated,
                "patientId":patientId,
                "bookingTime":bookingTime,
                "personId":personId]
    }
}

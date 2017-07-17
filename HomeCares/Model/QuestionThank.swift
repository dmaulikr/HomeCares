//
//  QuestionThank.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/11/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionThank: NSObject {
    
    // MARK: Property
    
    internal var questionThankId: Int!
    internal var questionId: Int!
    internal var created: String!
    internal var updated: String!
    internal var personId: Int!
    internal var userPerson: UserPerson!
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        questionThankId = json["questionThankId"].intValue
        questionId = json["questionId"].intValue
        created = json["created"].stringValue
        updated = json["created"].stringValue
        personId = json["personId"].intValue
        userPerson =  UserPerson(json: JSON(json["userPerson"].object))
    }

}

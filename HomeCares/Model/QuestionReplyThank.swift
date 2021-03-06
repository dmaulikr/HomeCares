//
//  QuestionReplyThank.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/11/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionReplyThank: NSObject {
    
    // MARK: Property
    
    internal var userPerson: UserPerson!
    internal var questionReplyThankId: Int!
    internal var created: String!
    internal var updated: String!
    internal var questionReplyId: Int!
    internal var personId: Int!
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        userPerson =  UserPerson(json: JSON(json["userPerson"].object))
        questionReplyThankId = json["questionReplyThankId"].intValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
        questionReplyId = json["questionReplyId"].intValue
        personId = json["personId"].intValue
    }
    
    
}

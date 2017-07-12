//
//  QuestionReply.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/11/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class QuestionReply: NSObject {
    
    // MARK: Property
    
    internal var questionReplyId: Int!
    internal var questionId: Int!
    internal var content: String!
    internal var created: String!
    internal var updated: String!
    internal var personId: Int!
    internal var userPerson: UserPerson!
    internal var questionReplyThanks: [QuestionReplyThank]!
    
    // MARK: Constructor
    
    public init(json: JSON) {
        questionReplyId = json["questionReplyId"].intValue
        questionId = json["questionId"].intValue
        content = json["content"].stringValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
        personId = json["personId"].intValue
        userPerson =  UserPerson(json: JSON(json["userPerson"].object))
        questionReplyThanks = json["questionReplyThanks"].arrayValue.map({QuestionReplyThank(json:$0)})
    }
}

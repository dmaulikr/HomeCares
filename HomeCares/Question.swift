//
//  Question.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class Question: NSObject {
    
    // MARK: Property
    
    internal var questionId: Int!
    internal var personId: Int!
    internal var allowEveryOneAnswer: Bool!
    internal var content: String!
    internal var created: String!
    internal var updated: String!
    internal var userPerson: UserPerson!
    internal var questionReplies: [QuestionReply]!
    internal var questionThanks: [QuestionThank]!

    // MARK: Constructor
    
    public override init() {
        super.init()
    }
    
    public init(json: JSON) {
        questionId = json["questionId"].intValue
        content = json["content"].stringValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
        personId = json["personId"].intValue
        allowEveryOneAnswer = json["allowEveryOneAnswer"].boolValue
        userPerson =  UserPerson(json: JSON(json["userPerson"].object))
        questionThanks = json["questionThanks"].arrayValue.map({QuestionThank(json:$0)})
        questionReplies = json["questionReplies"].arrayValue.map({QuestionReply(json:$0)})
    }
}

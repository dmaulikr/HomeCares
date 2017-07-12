//
//  HomeCaresService.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation

class HomeCaresService {
    
    // MARK: Property
    
    let apiHelper: ApiHelper!
    
    // MARK: Construction
    
    init() {
        apiHelper = ApiHelper(baseUrl: Configuration.BaseUrl)
    }
    
    // MARK: Internal method
    
    internal func login(userName: String, password: String, handler: @escaping (ApiResponse<User>) -> Void) {
        let parameters = ["userName" : userName,
                          "passwordHash" : password]
        apiHelper.post("\(Configuration.Api)/applicationLogin", parameters: parameters) { (json, error) in
            
            let response = ApiResponse<User>()
            if let json = json {
                response.data = User(json: json)
            }
            
            response.error = error
            handler(response)
        }
    }
    
    internal func getBlogs(handler: @escaping (ApiResponse<[Blog]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/blogs", parameters: nil) { (json, error) in
            let response = ApiResponse<[Blog]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Blog(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func getPatients(id: Int, handler: @escaping (ApiResponse<[Patient]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/getpatientsbyuserid/\(id)", parameters: nil) { (json, error) in
            let response = ApiResponse<[Patient]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Patient(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func getQuestions(handler: @escaping (ApiResponse<[Question]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/getQuestions", parameters: nil) { (json, error) in
            let response = ApiResponse<[Question]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Question(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func postQuestion(question: Question, handler: @escaping (ApiResponse<Question>) -> Void) {
        let paragrams = ["created": question.created,
                         "updated": question.updated,
                         "personId": question.personId,
                         "questionThanks": question.questionThanks,
                         "questionReplies": question.questionReplies,
                         "content": question.content,
                         "allowEveryOneAnswer": question.allowEveryOneAnswer] as [String:Any]
        
        apiHelper.post("\(Configuration.Api)/addQuestion", parameters: paragrams) { (json, error) in
            let response = ApiResponse<Question>()
            if let json = json {
                response.data = Question(json:json)
            }
            response.error = error
            handler(response)
        }
    }
}

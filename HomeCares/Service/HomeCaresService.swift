//
//  HomeCaresService.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

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
    
    internal func register(user: User, handler: @escaping (ApiResponse<User>) -> Void) {

        apiHelper.post("\(Configuration.Api)/applicationRegister", parameters: user.parameters) { (json, error) in
            
            let response = ApiResponse<User>()
            if let json = json {
                response.data = User(json: json)
            }
            
            response.error = error
            handler(response)
        }
    }
    
    internal func getUserPersonBy(userId: Int, handler: @escaping (ApiResponse<UserPerson>) -> Void) {
        apiHelper.get("\(Configuration.Api)/getUserPersonByUserId/\(userId)", parameters: nil) { (json, error) in
            let response = ApiResponse<UserPerson>()
            
            if let json = json {
                response.data = UserPerson(json: json)
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
    
    internal func getPatientsBy(personId: Int, handler: @escaping (ApiResponse<[Patient]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/getPatientsByPersonId/\(personId)", parameters: nil) { (json, error) in
            let response = ApiResponse<[Patient]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Patient(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func getPatientsBy(id: Int, handler: @escaping (ApiResponse<Patient>) -> Void) {
        apiHelper.get("\(Configuration.Api)/getPatientByPatientId/\(id)", parameters: nil) { (json, error) in
            let response = ApiResponse<Patient>()
            if let json = json {
                response.data = Patient(json: json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func deletePatientsBy(id: Int, handler: @escaping (ApiResponse<Patient>) -> Void) {
        apiHelper.delete("\(Configuration.Api)/Patients/\(id)", parameters: nil) { (json, error) in
            let response = ApiResponse<Patient>()
            if let json = json {
                response.data = Patient(json: json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func addPatient(patient: Patient, handler: @escaping (ApiResponse<Patient>) -> Void) {
        apiHelper.post("\(Configuration.Api)/Patients", parameters: patient.parameters) { (json, error) in
            let response = ApiResponse<Patient>()
            if let json = json {
                response.data = Patient(json: json)
            }
            response.error = error
            handler(response)
        }
    }

    
    internal func getQuestions(handler: @escaping (ApiResponse<[Question]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/Questions", parameters: nil) { (json, error) in
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
                         "allowEveryOneAnswer": "\(question.allowEveryOneAnswer!)"] as [String:Any]
        print("\(paragrams)")
        
        apiHelper.post("\(Configuration.Api)/Questions", parameters: paragrams) { (json, error) in
            let response = ApiResponse<Question>()
            if let json = json {
                response.data = Question(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func postReplyQuestion(question: QuestionReply, handler: @escaping (ApiResponse<QuestionReply>) -> Void) {
        let paragrams = ["created": question.created,
                         "updated": question.updated,
                         "personId": question.personId,
                         "questionId": question.questionId,
                         "questionReplyThanks": question.questionReplyThanks,
                         "content": question.content] as [String:Any]
        apiHelper.post("\(Configuration.Api)/QuestionReplies", parameters: paragrams) { (json, error) in
            let response = ApiResponse<QuestionReply>()
            if let json = json {
                response.data = QuestionReply(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func updateReplyQuestion(question: QuestionReply, handler: @escaping (ApiResponse<QuestionReply>) -> Void) {
        let paragrams = ["created": question.created,
                         "updated": question.updated,
                         "personId": question.personId,
                         "questionId": question.questionId,
                         "questionReplyId": question.questionReplyId,
                         "content": question.content] as [String:Any]

        apiHelper.put("\(Configuration.Api)/QuestionReplies/\(question.questionReplyId!)", parameters: paragrams, encoding: JSONEncoding.default) { (json, error) in
            let response = ApiResponse<QuestionReply>()
            if let json = json {
                response.data = QuestionReply(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func addQuestionThank(question: QuestionThank, handler: @escaping (ApiResponse<QuestionThank>) -> Void) {
        let paragrams = ["created": question.created,
                         "updated": question.updated,
                         "questionId":question.questionId,
                         "personId":question.personId,
                         ] as [String:Any]
        
        apiHelper.post("\(Configuration.Api)/QuestionThanks", parameters: paragrams) { (json, error) in
            let response = ApiResponse<QuestionThank>()
            if let json = json {
                response.data = QuestionThank(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func deleteQuestionThank(question: QuestionThank, handler: @escaping (ApiResponse<QuestionThank>) -> Void) {
        
        apiHelper.delete("\(Configuration.Api)/QuestionThanks/\(question.questionThankId!)", parameters: nil) { (json, error) in
            let response = ApiResponse<QuestionThank>()
            if let json = json {
                print("json \(json))")
                response.data = QuestionThank(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func addQuestionReplyThank(question: QuestionReplyThank, handler: @escaping (ApiResponse<QuestionReplyThank>) -> Void) {
        let paragrams = ["created": question.created,
                         "updated": question.updated,
                         "questionReplyId":question.questionReplyId,
                         "personId":question.personId,
                         ] as [String:Any]
        
        apiHelper.post("\(Configuration.Api)/QuestionReplyThanks", parameters: paragrams) { (json, error) in
            let response = ApiResponse<QuestionReplyThank>()
            if let json = json {
                response.data = QuestionReplyThank(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func deleteQuestionReplyThank(question: QuestionReplyThank, handler: @escaping (ApiResponse<QuestionReplyThank>) -> Void) {
        
        apiHelper.delete("\(Configuration.Api)/QuestionReplyThanks/\(question.questionReplyThankId!)", parameters: nil) { (json, error) in
            let response = ApiResponse<QuestionReplyThank>()
            if let json = json {
                print("json \(json))")
                response.data = QuestionReplyThank(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func addOrder(order: Order, handler: @escaping (ApiResponse<Order>) -> Void) {

        apiHelper.post("\(Configuration.Api)/Orders", parameters: order.parameters) { (json, error) in
            let response = ApiResponse<Order>()
           // print("\(json)")
            if let json = json {
                response.data = Order(json:json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func getMedicines(handler: @escaping (ApiResponse<[Medicine]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/Medicines", parameters: nil) { (json, error) in
            let response = ApiResponse<[Medicine]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Medicine(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    internal func getMedicines(key: String, handler: @escaping (ApiResponse<[Medicine]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/getMedicineByKeyWord/\(key)", parameters: nil) { (json, error) in
            let response = ApiResponse<[Medicine]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Medicine(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func getDisease(handler: @escaping (ApiResponse<[Disease]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/Diseases", parameters: nil) { (json, error) in
            let response = ApiResponse<[Disease]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Disease(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func getDisease(key: String, handler: @escaping (ApiResponse<[Disease]>) -> Void) {
        apiHelper.get("\(Configuration.Api)/GetDiseasesByKeyWord/\(key)", parameters: nil) { (json, error) in
            let response = ApiResponse<[Disease]>()
            
            if let json = json {
                response.data = json.arrayValue.map({Disease(json: $0)})
            }
            response.error = error
            handler(response)
        }
    }

    
    internal func updateUserPerson(userPerson: UserPerson, handler: @escaping (ApiResponse<UserPerson>) -> Void) {
        apiHelper.post("\(Configuration.Api)/updateUserPerson", parameters: userPerson.parametersUpdate) { (json, error) in
            let response = ApiResponse<UserPerson>()
            if let json = json {
                response.data = UserPerson(json: json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func updatePatient(patient: Patient, handler: @escaping (ApiResponse<Patient>) -> Void) {
        apiHelper.put("\(Configuration.Api)/Patients/\(patient.patientId!)", parameters: patient.parametersUpdate, encoding: JSONEncoding.default) { (json, error) in
            let response = ApiResponse<Patient>()
            if let json = json {
                response.data = Patient(json: json)
            }
            response.error = error
            handler(response)
        }
    }
    
    internal func changePatientAvatar(patientId: Int, image: Data, handler: @escaping (ApiResponse<UserPerson>) -> Void) {
        
        let parameters = ["patientId": patientId]
 
        apiHelper.upload("\(Configuration.Api)/changePatientAvatar",parameters:parameters, data: image) { (json, error) in
            print("json  \(json)   \n error \(error?.localizedDescription)")
        }
    }
}

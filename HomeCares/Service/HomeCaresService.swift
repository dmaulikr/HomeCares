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
                          "password" : password]
        apiHelper.post("\(Configuration.Api)/login", parameters: parameters) { (json, error) in
           
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
}

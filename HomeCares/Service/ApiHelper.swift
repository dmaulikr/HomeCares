//
//  ApiHelper.swift
//  View
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Alamofire
import SwiftyJSON

public typealias ServiceHandler<T> = (ApiResponse<T>) -> Void
public typealias ResponseHandler = (JSON?, Error?) -> Void

public class ApiHelper: NSObject {

    // MARK: Property
    
    fileprivate let baseUrl: String

    // MARK: Constructor
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    
        super.init()
    }
    
    // MARK: Private method
    
    fileprivate func request(
        _ url           : URLConvertible,
        method          : Alamofire.HTTPMethod,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : ResponseHandler? = nil) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(
                    "\(baseUrl)\(url)",
                    method      : method,
                    parameters  : parameters)
                 .validate(statusCode: 200..<300)
                 .responseJSON { response in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.handleResponse(response, responseHandler: responseHandler)
        }
    }

    fileprivate func handleResponse(_ response: DataResponse<Any>, responseHandler: ResponseHandler? = nil) {
        switch response.result {
        case .success:
            if let value = response.result.value {
                let json = JSON(value)
                responseHandler?(json, nil)
            } else {
                responseHandler?(nil, response.result.error)
            }
        case .failure(let error):
            responseHandler?(nil, error)
        }
    }

}

// MARK: REST Standard

extension ApiHelper {
    
    // MAKR: Public method
    
    public func get(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        responseHandler : ResponseHandler? = nil) {
        
        request(
            url,
            method          : .get,
            parameters      : parameters,
            responseHandler : responseHandler
        )
    }
    
    public func post(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        responseHandler : ResponseHandler? = nil) {
        
        request(
            url,
            method          : .post,
            parameters      : parameters,
            responseHandler : responseHandler
        )
    }
    
    public func put(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : ResponseHandler? = nil) {
        
        request(
            url,
            method          : .put,
            parameters      : parameters,
            encoding        : encoding,
            headers         : headers,
            responseHandler : responseHandler
        )
    }

    
    public func delete(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        encoding        : ParameterEncoding = URLEncoding.default,
        headers         : HTTPHeaders? = nil,
        responseHandler : ResponseHandler? = nil) {
        
        request(
            url,
            method          : .delete,
            parameters      : parameters,
            encoding        : encoding,
            headers         : headers,
            responseHandler : responseHandler
        )
    }
    
    public func upload(
        _ url           : URLConvertible,
        parameters      : Parameters? = nil,
        headers         : HTTPHeaders? = nil,
        data            : Data,
        responseHandler : ResponseHandler? = nil) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.upload(multipartFormData: { (formData) in
            
            if let hasParam = parameters {
                for (key, value) in hasParam {
                    if let data = value as? Data {
                        formData.append(data, withName: key)
                    } else {
                        formData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
//            formData.append(data, withName: "upload")
            formData.append(data, withName: "upload", mimeType: "image/png")
        }, to: "\(baseUrl)\(url)", headers: headers) { (completion) in
            switch completion {
            case .success(let request, _, _):
                request.responseJSON { (response) in
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.handleResponse(response, responseHandler: responseHandler)
                }
            case .failure(let error):
                responseHandler?(nil, error)
            }
        }
    }

}

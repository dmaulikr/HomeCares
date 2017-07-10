//
//  ApiResponse.swift
//  View
//
//  Created by Tuat Tran on 7/3/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import SwiftyJSON

public class ApiResponse<T>: NSObject {

    // MARK: Property
    
    public var error: Error?
    public var data: T?
    
}

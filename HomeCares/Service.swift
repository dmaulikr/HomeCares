//
//  Service.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/5/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class Service: NSObject {
    
    // MARK: Property
    
    internal var id: Int!
    internal var name: String!
    internal var overview: String!
    internal var detail: String!
    internal var updated: Date!
    internal var created: Date!
    
    public init(json: JSON) {
        name = json["name"].stringValue
        overview = json["overview"].stringValue
        detail = json["detail"].stringValue
    }
}

//
//  Disease.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/21/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import  SwiftyJSON

class Disease: NSObject {
    
    internal var diseasesId: Int!
    internal var name: String!
    internal var summary: String!
    internal var overview: String!
    internal var cause: String!
    internal var images: String!
    internal var precaution: String!
    internal var treatment: String!
    internal var facebookLink: String!
    internal var created: String!
    internal var updated: String!
    
    public init(json: JSON) {
        diseasesId = json["diseasesId"].intValue
        name = json["name"].stringValue
        summary = json["summary"].stringValue
        overview = json["overview"].stringValue
        cause = json["cause"].stringValue
        images = json["images"].stringValue
        precaution = json["precaution"].stringValue
        treatment = json["treatment"].stringValue
        facebookLink = json["facebookLink"].stringValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
    }
}

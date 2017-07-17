//
//  MedicineGroup.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/16/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class MedicineGroup: NSObject {
    
    // MARK: Property
    
    internal var groupId: Int!
    internal var groupName: String!
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        groupId = json["groupId"].intValue
        groupName = json["groupName"].stringValue
    }
}

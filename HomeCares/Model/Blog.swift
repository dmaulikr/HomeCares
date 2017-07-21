//
//  Blog.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class Blog: NSObject {
    
    // MARK: Property
    
    internal var blogId: Int!
    internal var title: String!
    internal var content: String!
    internal var imageLink: String!
    internal var category: String!
    internal var created: String!
    internal var descriptionBlog: String!
    internal var postType: Int!
    
    // MARK: Constructor
    
    public init(json: JSON) {
        blogId = json["blogId"].intValue
        postType = json["postType"].intValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        imageLink = "\(Configuration.BaseUrl)/\(json["previewImage"].stringValue)"
        created = json["created"].stringValue
        descriptionBlog = json["description"].stringValue
        category = json["category"].stringValue
    }
    
}

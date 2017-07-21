//
//  OptionMenu.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/8/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

enum OptionMenuType: Int {
    case call = 0, schedule, searchMedical, searchDisease, none
}

class OptionMenu: NSObject {
    
    // MARK: Property
    
    internal var name: String!
    internal var type: OptionMenuType!
    internal var image: UIImage!
    internal var link: String!
    
    
    // MARK: Constructor
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        name = json["name"].stringValue
        if let type = OptionMenuType(rawValue: json["type"].intValue) {
            self.type = type
        } else {
            type = .none
        }
        image = json["image"].stringValue.image
    }
    
    public static func getMenus(of key: String) -> [OptionMenu] {
        if let url = Bundle.workRoster.url(forResource: "ServiceItem", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let dictionary = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
            
            let menuItem = dictionary?[key] as? [Any] {
            
            var menus = [OptionMenu]()
            menuItem.forEach({ (value) in
                menus.append(OptionMenu(json: JSON(value)))
            })
            return menus
        }
        return []
    }
}

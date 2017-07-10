//
//  ServiceItem.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/5/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public class ServiceItem: NSObject {
    
    // MARK: Property
    
    internal var backGroundColor: UIColor!
    internal var type: Int!
    internal var icon: UIImage!
    internal var service: Service!
    
    // MARK: Constructor
    
    public init(json: JSON) {
        if let hexValue = UInt(String(json["background"].stringValue.characters.suffix(6)), radix: 16) {
            backGroundColor = UIColor(hex: Int(hexValue))
        }
        type = json["type"].intValue
        icon = json["icon"].stringValue.image
        service = Service(json: json)
    }
    
    public static func getMenus(of key: String) -> [ServiceItem] {
        if let url = Bundle.workRoster.url(forResource: "ServiceItem", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let dictionary = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
            
            let menuItem = dictionary?[key] as? [Any] {
            
            var menus = [ServiceItem]()
            menuItem.forEach({ (value) in
                menus.append(ServiceItem(json: JSON(value)))
            })
            return menus
        }
        return []
    }
    
}

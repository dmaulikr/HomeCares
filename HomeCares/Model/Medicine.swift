//
//  Medicine.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/16/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SwiftyJSON

class Medicine: NSObject {
    
    // MARK: Property
    
    internal var medicineId: Int!
    internal var name: String!
    internal var registerCode: String!
    internal var packageName: String!
    internal var standard: String!
    internal var longevity: String!
    internal var manufacturingCompany: String!
    internal var manufacturingCountry: String!
    internal var companyRegister: String!
    internal var countryRegister: String!
    internal var informations: String!
    internal var physicType: String!
    internal var methodType: String!
    internal var instructions: String!
    internal var warnning: String!
    internal var indication: String!
    internal var contraindication: String!
    internal var sideEffects: String!
    internal var note: String!
    internal var overdose: String!
    internal var preservation: String!
    internal var forgotToTakeDrugs: String!
    internal var diet: String!
    internal var interaction: String!
    internal var pharmacological: String!
    internal var pharmacokinetics: String!
    internal var groupId: Int!
    internal var medicineGroups: MedicineGroup!
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        medicineId = json["medicineId"].intValue
        name = json["name"].stringValue
        registerCode = json["registerCode"].stringValue
        packageName = json["packageName"].stringValue
        standard = json["standard"].stringValue
        longevity = json["longevity"].stringValue
        manufacturingCompany = json["manufacturingCompany"].stringValue
        manufacturingCountry = json["manufacturingCountry"].stringValue
        companyRegister = json["companyRegister"].stringValue
        countryRegister = json["countryRegister"].stringValue
        informations = json["informations"].stringValue
        physicType = json["physicType"].stringValue
        methodType = json["methodType"].stringValue
        instructions = json["instructions"].stringValue
        warnning = json["warnning"].stringValue
        indication = json["indication"].stringValue
        contraindication = json["contraindication"].stringValue
        sideEffects = json["sideEffects"].stringValue
        note = json["note"].stringValue
        overdose = json["overdose"].stringValue
        preservation = json["preservation"].stringValue
        forgotToTakeDrugs = json["forgotToTakeDrugs"].stringValue
        diet = json["diet"].stringValue
        interaction = json["interaction"].stringValue
        pharmacological = json["pharmacological"].stringValue
        pharmacokinetics = json["pharmacokinetics"].stringValue
        groupId = json["groupId"].intValue
        medicineGroups = MedicineGroup(json: JSON(json["medicineGroups"].object))
    }
}

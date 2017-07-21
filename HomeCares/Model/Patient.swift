//
//  Patient.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/9/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public enum PatientRelations: Int {
    case me = 0,
    son,
    dauther,
    father,
    mother,
    fatherInLaw,
    motherInlaw,
    grandFather,
    grandMother,
    grandFatherInLaw,
    grandMotherInLaw,
    elderBrother,
    elderSister,
    youngerBrother,
    youngerSister,
    elderBrotherInLaw,
    elderSisterInLaw,
    youngerBrotherInLaw,
    youngerSisterInlaw,
    neighbor,
    other
}

enum Gender: Int {
    case female = 0, male = 1, other = 2
}

class Patient: NSObject {
    
    // MARK: Property

    internal var patientId: Int!
    internal var personId: Int!
    internal var patientRelations: PatientRelations!
    internal var firstName: String!
    internal var middleName: String!
    internal var lastName: String!
    internal var dateOfBirth: String!
    internal var gender: Gender!
    internal var phone: String!
    internal var email: String!
    internal var address: String!
    internal var latitude: Double!
    internal var longitude: Double!
    internal var idCardNumber: String!
    internal var insuranceNumber: String!
    internal var medicalHistory: String!
    internal var healthOverview: String!
    internal var avatar: String!
    internal var allergyHistory: String!
    internal var note: String!
    internal var created: String!
    internal var updated: String!
    internal var subInfor: String {
        get {
            if let date = DateHelper.shared.date(from: self.dateOfBirth, format: .yyyy_MM_dd_T_HH_mm_ss_Z) {
                return self.gender! == .male ? "Male - " + " \(date.age) years old." : self.gender! == .male ? "Female - " + " \(date.age) years old.": "Other - "  + " \(date.age) years old."
            }
            return ""
        }
    }
    
    // MARK: Constructor
    
    override init() {
        super.init()
    }
    
    public init(json: JSON) {
        patientId = json["patientId"].intValue
        personId =  json["personId"].intValue
        patientRelations = PatientRelations(rawValue: json["patientRelations"].intValue)
        firstName = json["firstName"].stringValue
        middleName = json["middleName"].stringValue
        lastName = json["lastName"].stringValue
        dateOfBirth = json["dateOfBirth"].stringValue
        gender = Gender(rawValue: json["gender"].intValue)
        phone = json["phone"].stringValue
        email = json["email"].stringValue
        address = json["address"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        idCardNumber = json["idCardNumber"].stringValue
        insuranceNumber = json["insuranceNumber"].stringValue
        medicalHistory = json["medicalHistory"].stringValue
        healthOverview = json["healthOverview"].stringValue
        avatar = "\(Configuration.BaseUrl)\(json["avatar"].stringValue)"
        allergyHistory = json["allergyHistory"].stringValue
        note = json["note"].stringValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
    }
    
    internal var parameters: [String: Any] {
        return ["personId":personId,
                "patientRelations":patientRelations.rawValue,
                "firstName":firstName,
                "middleName":middleName,
                "lastName":lastName,
                "dateOfBirth":dateOfBirth,
                "gender":gender.rawValue,
                "created":created,
                "updated":updated,
                "phone":phone]
    }
    internal var parametersUpdate: [String: Any] {
        return ["personId":personId,
                "patientRelations":patientRelations.rawValue,
                "firstName":firstName,
                "middleName":middleName,
                "lastName":lastName,
                "dateOfBirth":dateOfBirth,
                "gender":gender.rawValue,
                "created":created,
                "updated":updated,
                "idCardNumber":idCardNumber,
                "insuranceNumber":insuranceNumber,
                "healthOverview":healthOverview,
                "medicalHistory":medicalHistory,
                "allergyHistory":allergyHistory,
                "address":address,
                "phone":phone,
                "email":email,
                "patientId":patientId,
                "longitude":longitude,
                "latitude":latitude,
                "avatar":avatar]
    }
}

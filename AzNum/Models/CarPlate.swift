//
//  CarPlate.swift
//  AzNum
//
//  Created by Babek Gadirli on 30.10.23.
//

import Foundation

struct CarPlate {
    let id: String
    let plateSeries: String
    let plateFirstChar: String
    let plateSecondChar: String
    let plateEnding: String
    let owner: String
    let ownerID: String
    let phoneNumber: String
    let price: String
    let description: String
    let date: Any
    
    func toDictionary() -> [String: Any] {
        return [
            "plateSeries": plateSeries,
            "plateFirstChar": plateFirstChar,
            "plateSecondChar": plateSecondChar,
            "plateEnding": plateEnding,
            "price": price,
            "owner": owner,
            "ownerID": ownerID,
            "phoneNumber": phoneNumber,
            "description": description,
            "date": date
        ]
    }
    
    init(id: String, plateSeries: String, plateFirstChar: String, plateSecondChar: String, plateEnding: String, owner: String, ownerID: String, phoneNumber: String, price: String, description: String, date: Any) {
        self.id = id
        self.plateSeries = plateSeries
        self.plateFirstChar = plateFirstChar
        self.plateSecondChar = plateSecondChar
        self.plateEnding = plateEnding
        self.owner = owner
        self.ownerID = ownerID
        self.phoneNumber = phoneNumber
        self.price = price
        self.description = description
        self.date = date
    }
    
    init(id: String, dict: [String: Any]) {
        self.id = id
        self.plateSeries = dict["plateSeries"] as? String ?? ""
        self.plateFirstChar = dict["plateFirstChar"] as? String ?? ""
        self.plateSecondChar = dict["plateSecondChar"] as? String ?? ""
        self.plateEnding = dict["plateEnding"] as? String ?? ""
        self.owner = dict["owner"] as? String ?? ""
        self.ownerID = dict["ownerID"] as? String ?? ""
        self.phoneNumber = dict["phoneNumber"] as? String ?? ""
        self.price = dict["price"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
        self.date = dict["date"] as? String ?? ""
    }
    
    
}

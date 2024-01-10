//
//  Constants.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import Firebase

let PLATE_REF = Database.database().reference().child("car_plate_items")
let USER_REF = Database.database().reference().child("users")

let PHONE_OPERATORS = [
                        "050",
                        "051",
                        "055",
                        "070",
                        "077",
                        "099"
                        ]

let SERIES = Array(1...99).map { String(format: "%02d", $0) }
let LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "X", "Y", "Z"]


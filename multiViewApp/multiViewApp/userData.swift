//
//  userData.swift
//  multiViewApp
//
//  Created by Nabeel Ahmad Khan on 28/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation

class userData: NSObject, NSCoding {
    
    var name: String
    var email: String
    var sex: String
    var calculator: Double
    var game: Int
    var date: String
    
    // Memberwise initializer
    init(name: String, email: String, sex: String, calculator: Double, game: Int, date: String) {
        self.name = name
        self.email = email
        self.sex = sex
        self.calculator = calculator
        self.game = game
        self.date = date
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let email = decoder.decodeObject(forKey: "email") as? String,
            let sex = decoder.decodeObject(forKey: "sex") as? String,
            let date = decoder.decodeObject(forKey: "date") as? String
            else { return nil }
        
        self.init(
            name: name,
            email: email,
            sex: sex,
            calculator: decoder.decodeDouble(forKey: "calculator"),
            game: decoder.decodeInteger(forKey: "game"),
            date: date
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.sex, forKey: "sex")
        aCoder.encode(self.calculator, forKey: "calculator")
        aCoder.encode(self.game, forKey: "game")
        aCoder.encode(self.date, forKey: "date")
    }
}

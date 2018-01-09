//
//  dateFormatter.swift
//  FNFA
//
//  Created by Robin Minervini on 09/01/2018.
//  Copyright © 2018 Robin Minervini. All rights reserved.
//

import Foundation

extension Date {
    
    var nameNumberDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d"
        return formatter.string(from: self)
    }
    var nameNumberMonthDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: self)
    }
    
    var hourDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

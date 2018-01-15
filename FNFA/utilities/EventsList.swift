//
//  EventsList.swift
//  FNFA
//
//  Created by Robin Minervini on 24/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import Foundation

// Structure du JSON

struct EventList : Decodable {
    let id: Int
    let name: String
    var excerpt: String
    var categoryId: Int
    var category: String
    var placeIds: Array<Int>
    var place: Array<String>
    var startingDate: String
    var startingDateDayNumber: String
}

struct CategoryList : Decodable {
    let id: Int
    let name: String
}

struct PlaceList : Decodable {
    let id: Int
    let name: String
}


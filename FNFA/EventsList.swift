//
//  EventsList.swift
//  FNFA
//
//  Created by Robin Minervini on 24/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import Foundation

struct EventList : Decodable {
    // Valeurs conditionnelles pour le cas où une valeur d'un objet du Json n'est pas définie
    // (Ex : si un objet n'a pas de link)
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
    // Valeurs conditionnelles pour le cas où une valeur d'un objet du Json n'est pas définie
    // (Ex : si un objet n'a pas de link)
    let id: Int
    let name: String
}

struct PlaceList : Decodable {
    // Valeurs conditionnelles pour le cas où une valeur d'un objet du Json n'est pas définie
    // (Ex : si un objet n'a pas de link)
    let id: Int
    let name: String
}


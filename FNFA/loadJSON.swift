//
//  loadJSON.swift
//  FNFA
//
//  Created by Datagif 01 on 05/01/2018.
//  Copyright © 2018 Robin Minervini. All rights reserved.
//

import Foundation

var events = [EventList]()
var categories = [CategoryList]()
var places = [PlaceList]()
var filteredEvents = [EventList]()

func downloadJson(completed: @escaping () -> ()) {
    
    // Load Category Json
    let pathCategories = Bundle.main.path(forResource: "categories", ofType: "json")
    
    let urlCategories = URL(fileURLWithPath: pathCategories!)
    
    do {
        let dataCategories = try Data(contentsOf: urlCategories)
        categories = try JSONDecoder().decode([CategoryList].self, from: dataCategories)
        
        DispatchQueue.main.async {
            completed()
        }
    }
    catch {
        print(error)
    }
    
    // Load Places Json
    let pathPlaces = Bundle.main.path(forResource: "places", ofType: "json")
    
    let urlPlaces = URL(fileURLWithPath: pathPlaces!)
    
    do {
        let dataPlaces = try Data(contentsOf: urlPlaces)
        places = try JSONDecoder().decode([PlaceList].self, from: dataPlaces)
        DispatchQueue.main.async {
            completed()
        }
    }
    catch {
        print(error)
    }
    
    // Load Events Json
    let pathEvents = Bundle.main.path(forResource: "events", ofType: "json")
    
    let urlEvents = URL(fileURLWithPath: pathEvents!)
    
    do {
        let dataEvents = try Data(contentsOf: urlEvents)
        events = try JSONDecoder().decode([EventList].self, from: dataEvents)
        
        var l = 0


        while l<events.count{
            
            let formatter = ISO8601DateFormatter()
            let dateIso = events[l].startingDate
            if let date = formatter.date(from: dateIso) {
                events[l].startingDateDayNumber = date.nameNumberDate.capitalized
            }
            
            l = l + 1
        }
        
        
        var i = 0
        var j = 0
        var k = 0
        var h = 0
        
        //TODO: - Utiliser une boucle for .. in .. ?
        while j<categories.count {
            i = 0
            
            while i<events.count {
                if events[i].categoryId == categories[j].id {
                    events[i].category = categories[j].name
                }
                
                i = i + 1
            }
            
            j = j + 1
        }
        
        while h<places.count {
            i = 0
            
            while i<events.count {
                k = 0
                while k < events[i].placeIds.count {
                    if events[i].placeIds[k] == places[h].id {
                        events[i].place.append(places[h].name)
                    }
                    k = k + 1
                }
                i = i + 1
            }
            
            h = h + 1
        }
        
        filteredEvents = events
        //print(filteredEvents)
        DispatchQueue.main.async {
            completed()
        }
    }
    catch {
        print(error)
    }
}


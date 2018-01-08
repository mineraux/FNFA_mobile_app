//
//  CoreDataHandler.swift
//  FNFA
//
//  Created by Robin Minervini on 02/01/2018.
//  Copyright © 2018 Robin Minervini. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(eventname: String, eventcategory: String, eventdate: String, eventplaces: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(eventname, forKey: "eventname")
        manageObject.setValue(eventcategory, forKey: "eventcategory")
        manageObject.setValue(eventdate, forKey: "eventdate")
        manageObject.setValue(eventplaces, forKey: "eventplaces")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func fetchObject() -> [Event]? {
        let context = getContext()
        var event:[Event]? = nil
        do {
            event = try context.fetch(Event.fetchRequest())
            return event
        } catch {
            return event
        }
    }
    
    class func deleteObject(event: Event) -> Bool {
        let context = getContext()
        context.delete(event)
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Event.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
    
}


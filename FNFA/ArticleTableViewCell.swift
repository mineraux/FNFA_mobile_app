//
//  ArticleTableViewCell.swift
//  FNFA
//
//  Created by Robin Minervini on 01/01/2018.
//  Copyright © 2018 Robin Minervini. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventPlace: UILabel!    
    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var addToFavBtn: UIButton!
    
    var event: [Event]? = nil
    var eventAlreadyFav = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addToFavTn(_ sender: Any) {
        // MARK: - CoreDataManager
        
        event = CoreDataHandler.fetchObject()
        if event?.count == 0 {
            if CoreDataHandler.saveObject(eventname: eventTitle.text!, eventcategory: eventCategory.text!, eventdate: eventDate.text!, eventplaces: eventPlace.text!) {
                event = CoreDataHandler.fetchObject()
            }
        }
        
        // Gestion du cas ou un événement est déjà en favoris
        for i in event! {
            if i.eventname != eventTitle.text! {
                eventAlreadyFav = false
            } else {
                return
            }
        }
        
        if eventAlreadyFav == false {
            if CoreDataHandler.saveObject(eventname: eventTitle.text!, eventcategory: eventCategory.text!, eventdate: eventDate.text!, eventplaces: eventPlace.text!) {
                event = CoreDataHandler.fetchObject()
                //            for i in event! {
                //                print(i.eventname)
                //            }
                
                //Delete single event
                //            if CoreDataHandler.deleteObject(event: event![1]) {
                //                event = CoreDataHandler.fetchObject()
                //                print("After Single delete")
                //                for i in event! {
                //                    print(i.eventname)
                //                }
                //
                //                print(event?.count)
                //            }
                
                // Delete all event
                //            if CoreDataHandler.cleanDelete() {
                //                event = CoreDataHandler.fetchObject()
                //                print(event?.count)
                //            }
                
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


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
    @IBOutlet weak var allEventCellView: UIView!
    
    var event: [Event]? = nil
    var eventAlreadyFav = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        event = CoreDataHandler.fetchObject()
        
        allEventCellView.layer.cornerRadius = 6
        self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    
    @IBAction func addToFavTn(_ sender: Any) {
        // MARK: - CoreDataManager
        
        event = CoreDataHandler.fetchObject()

        if event?.count == 0 {
            if CoreDataHandler.saveObject(eventname: eventTitle.text!, eventcategory: eventCategory.text!, eventdate: eventDate.text!, eventplaces: eventPlace.text!) {
                event = CoreDataHandler.fetchObject()
                self.addToFavBtn.setImage(UIImage(named: "heart_full"), for: .normal)
            }
        } else {
            // Gestion du cas ou un événement est déjà en favoris
            for i in event! {
                if i.eventname != eventTitle.text! {
                    eventAlreadyFav = false
                    self.addToFavBtn.setImage(UIImage(named: "heart_full"), for: .normal)
                } else {
                    self.addToFavBtn.setImage(UIImage(named: "heart_empty"), for: .normal)
                    if CoreDataHandler.deleteObject(event: i) {
                        event = CoreDataHandler.fetchObject()
                    }
                    return
                }
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


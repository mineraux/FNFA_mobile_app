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

        // Si aucun événement est enregistré, on ajoute l'événement au clique sur le btn
        if event?.count == 0 {
            if CoreDataHandler.saveObject(eventname: eventTitle.text!, eventcategory: eventCategory.text!, eventdate: eventDate.text!, eventplaces: eventPlace.text!) {
                event = CoreDataHandler.fetchObject()
                self.addToFavBtn.setImage(UIImage(named: "heart_full"), for: .normal)
            }
        } else {
            // Si il y a déjà au moins 1 event enregistré, on test si le nom de l'événement cliqué match avec un evenement enregistré
            // Si non, on met l'image du coeur plein (pas en fav)
            // Si oui, on met l'image du coeur vide (en fav) et on supprime l'événement de la liste des favoris
            for i in event! {
                if i.eventname != eventTitle.text! {
                    eventAlreadyFav = false
                    let image = UIImage(named: "heart_full")
                    self.addToFavBtn.setImage(image, for: .normal)
                    
                } else {
                    self.addToFavBtn.setImage(UIImage(named: "heart_empty"), for: .normal)
                    if CoreDataHandler.deleteObject(event: i) {
                        event = CoreDataHandler.fetchObject()
                    }
                    return
                }
            }
        }
        
        // Si evenement pas encore en favoris, on l'enregistre
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


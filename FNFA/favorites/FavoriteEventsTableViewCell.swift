//
//  FavoriteEventsTableViewCell.swift
//  FNFA
//
//  Created by Robin Minervini on 02/01/2018.
//  Copyright © 2018 Robin Minervini. All rights reserved.
//

import UIKit

class FavoriteEventsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var eventCategory: UILabel!
    @IBOutlet weak var eventName: UILabel!    
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventPlaces: UILabel!
    @IBOutlet weak var eventThumbnail: UIImageView!
    
    var event: [Event]? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func removeEventFromFav(_ sender: Any) {
        event = CoreDataHandler.fetchObject()
        
        for event in event! {
            if event.eventname == eventName.text {
                if CoreDataHandler.deleteObject(event: event) {
                    
                }
            }
        }
        
        // Reload la tableView des favoris pour mettre à jour la liste quand on retire un evenement
        // (besoin de push un notification car tableView dans une autre class)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
}



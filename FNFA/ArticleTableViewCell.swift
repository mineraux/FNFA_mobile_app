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
    @IBOutlet weak var addToFavBtn: UIButton!
    
    
    var event: [Event]? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addToFavTn(_ sender: Any) {
        // MARK: - CoreDataManager
        
        if CoreDataHandler.saveObject(eventname: eventTitle.text!, eventcategory: eventCategory.text!) {
            event = CoreDataHandler.fetchObject()
//            for i in event! {
//                print(i.eventname)
//            }

//            if CoreDataHandler.deleteObject(event: event![1]) {
//                event = CoreDataHandler.fetchObject()
//                print("After Single delete")
//                for i in event! {
//                    print(i.eventname)
//                }
//
//                print(event?.count)
//            }

//                    if CoreDataHandler.cleanDelete() {
//                        event = CoreDataHandler.fetchObject()
//                        print(event?.count)
//                    }

        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

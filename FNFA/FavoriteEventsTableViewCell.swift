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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


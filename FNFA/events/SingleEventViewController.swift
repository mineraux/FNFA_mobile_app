//
//  SingleEventViewController.swift
//  FNFA
//
//  Created by Robin Minervini on 24/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import UIKit

class SingleEventViewController: UIViewController {

    @IBOutlet weak var eventThumbnail: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventPlace: UILabel!
    @IBOutlet weak var eventExcerpt: UILabel!
    
    var event:EventList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventName.text = event?.name
        
        let dateIso = event?.startingDate
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withYear, .withMonth, .withDay, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        formatter.timeZone = TimeZone(identifier: "Europe/Paris")
        if let date = formatter.date(from: dateIso!) {
            eventDate.text = date.hourDate
        }
    
        eventPlace.text = event?.place.joined(separator: ", ")
        eventExcerpt.text = event?.excerpt
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


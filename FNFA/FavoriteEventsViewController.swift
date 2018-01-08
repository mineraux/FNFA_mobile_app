//
//  FavoriteEventsViewController.swift
//  FNFA
//
//  Created by Robin Minervini on 02/01/2018.
//  Copyright © 2018 Robin Minervini. All rights reserved.
//

import UIKit
import CoreData

class FavoriteEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var event: [Event]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 110
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        event = CoreDataHandler.fetchObject()
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        event = CoreDataHandler.fetchObject()
        return (event?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteEventCell", for: indexPath) as! FavoriteEventsTableViewCell
        
        event = CoreDataHandler.fetchObject()
        
        cell.eventCategory.text = event![indexPath.row].eventcategory
        cell.eventName!.text = event![indexPath.row].eventname
        cell.eventDate!.text = event![indexPath.row].eventdate
        cell.eventPlaces!.text = event![indexPath.row].eventplaces
        
        // Gestion des caractères spéciaux
        var imageName = cell.eventName.text!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        imageName = imageName.replacingOccurrences(of: "°", with: "", options: .literal, range: nil)
        imageName = imageName.replacingOccurrences(of: "é|è|ê", with: "e", options: .literal, range: nil)
        imageName = imageName.lowercased()
        
        cell.eventThumbnail!.image = UIImage(named:imageName)
        
        if cell.eventThumbnail!.image == nil {
            cell.eventThumbnail!.image = UIImage(named:"default")
        }
        
        return cell
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


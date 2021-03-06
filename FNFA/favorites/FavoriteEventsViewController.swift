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
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        tableView.rowHeight = 110
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func loadList(){
        //load data here
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // reload la tableView quand on arrive sur la page
    override func viewDidAppear(_ animated: Bool) {
        event = CoreDataHandler.fetchObject()
        
        self.tableView.reloadData()
    }
    
    // Nombre de ligne dans la tableView = nombre d'élément enregistré
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
        
        // Gestion des caractères spéciaux pour définir dynamiquement l'image de chaqué événement. Il faut que l'image est le même nom
        // que l'évenement (Ex : eventName = Scéance spéciale ; nom image = sceance_speciale.png
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


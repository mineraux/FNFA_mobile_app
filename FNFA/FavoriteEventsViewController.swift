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
//        for i in event! {
////            print(i.eventname)
////            print(i.eventcategory)
//            print(i)
//        }
        print((event?.count)!)
        
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        event = CoreDataHandler.fetchObject()
        return (event?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteEventCell", for: indexPath) as! FavoriteEventsTableViewCell
        event = CoreDataHandler.fetchObject()

        cell.eventName!.text = event![indexPath.row].eventname
        
        cell.eventName!.text = "test"
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

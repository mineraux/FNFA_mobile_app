//
//  allEventsController.swift
//  FNFA
//
//  Created by Robin Minervini on 25/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import UIKit

class allEventsController: UITableViewController {
    
    var events = [EventsList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = events[indexPath.row].name
        return cell
    }
    
    // MARK: - Filter
    
    @IBAction func buttonAction(_ sender: Any) {
        events = events.filter { $0.category == "Séance spéciale" }
        self.tableView.reloadData()
    }

    @IBAction func filter2(_ sender: Any) {
        events = events.filter { $0.category == "Salon des nouvelles écritures" }
        self.tableView.reloadData()
    }
    
    // MARK: - Pass data when tap on cell
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SingleEventViewController {
            destination.event = events[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // MARK: - Load Json

    func downloadJson(completed: @escaping () -> ()) {
        let path = Bundle.main.path(forResource: "events", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            self.events = try JSONDecoder().decode([EventsList].self, from: data)
            
            DispatchQueue.main.async {
                completed()
            }
        }
        catch {
            print("error json")
        }
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

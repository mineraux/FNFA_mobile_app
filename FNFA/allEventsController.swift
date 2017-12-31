//
//  allEventsController.swift
//  FNFA
//
//  Created by Robin Minervini on 30/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import UIKit

class allEventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtersTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var filterButtonSeanceSpe: UIButton!
    @IBOutlet weak var filterButtonNouvellesEcritures: UIButton!
    
    var events = [EventsList]()
    var filteredEvents = [EventsList]()
    var isFiltersHidden = true
    var activeFilters = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        filtersTrailingConstraint.constant = 300
        
        filterButtonSeanceSpe.backgroundColor = .clear
        filterButtonSeanceSpe.layer.cornerRadius = 10
        filterButtonSeanceSpe.layer.borderWidth = 2
        filterButtonSeanceSpe.layer.borderColor = UIColor.black.cgColor
        
        filterButtonNouvellesEcritures.backgroundColor = .clear
        filterButtonNouvellesEcritures.layer.cornerRadius = 10
        filterButtonNouvellesEcritures.layer.borderWidth = 2
        filterButtonNouvellesEcritures.layer.borderColor = UIColor.black.cgColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load Json
    
    func downloadJson(completed: @escaping () -> ()) {
        let path = Bundle.main.path(forResource: "events", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            self.events = try JSONDecoder().decode([EventsList].self, from: data)
            self.filteredEvents = try JSONDecoder().decode([EventsList].self, from: data)
            
            DispatchQueue.main.async {
                completed()
            }
        }
        catch {
            print("error json")
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = filteredEvents[indexPath.row].name

        return cell
    }
    
    // MARK: - Filter
    
        // Menu show/hide on click
    @IBAction func filtersButton(_ sender: Any) {
        if isFiltersHidden {
            filtersTrailingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            filtersTrailingConstraint.constant = 300
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isFiltersHidden = !isFiltersHidden
    }
    
    
    
    @IBAction func filterButtonSeanceSpe(_ sender: Any) {
        if let index = activeFilters.index(of: "Séance spéciale") {
            activeFilters.remove(at: index)
            filterButtonSeanceSpe.backgroundColor = .clear
        } else {
            activeFilters.append("Séance spéciale")
            filterButtonSeanceSpe.backgroundColor = UIColor.yellow
        }
        
        filterEvent()
    }
    
    @IBAction func filterButtonNouvellesEcritures(_ sender: Any) {
        if let index = activeFilters.index(of: "Salon des nouvelles écritures") {
            activeFilters.remove(at: index)
            filterButtonNouvellesEcritures.backgroundColor = .clear
        } else {
            activeFilters.append("Salon des nouvelles écritures")
            filterButtonNouvellesEcritures.backgroundColor = UIColor.yellow
        }

        filterEvent()
    }
    
    func filterEvent(){
        for filter in activeFilters {
            filteredEvents = events.filter { $0.category == filter }
        }
        
        if activeFilters.isEmpty {
            filteredEvents = events
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func reinitFilters(_ sender: Any) {
        filteredEvents = events
        self.tableView.reloadData()
    }
    
    // MARK: - Pass data when tap on cell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SingleEventViewController {
            destination.event = events[(tableView.indexPathForSelectedRow?.row)!]
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


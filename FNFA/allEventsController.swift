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
    
    var button = dropDownBtn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson {
            self.tableView.reloadData()
        }
        
        tableView.rowHeight = 110
        
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
        
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Date", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        //        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1.0, constant: 20.0).isActive = true
//
//        NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.topMargin, multiplier: 1.0, constant: 20.0).isActive = true
        
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.dropView.dropDownOptions =  ["Mercredi 4", "Jeudi 5", "Vendredi 6", "Samedi 7", "Dimanche 8"]
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Load Json
    
    func downloadJson(completed: @escaping () -> ()) {
//        let path = Bundle.main.path(forResource: "events", ofType: "json")
//
//        let url = URL(fileURLWithPath: path!)
//        do {
//            let data = try Data(contentsOf: url)
//            self.events = try JSONDecoder().decode([EventsList].self, from: data)
//            self.filteredEvents = try JSONDecoder().decode([EventsList].self, from: data)
//
//            DispatchQueue.main.async {
//                completed()
//            }
//        }
//        catch {
//            print(error)
//        }
        
        typealias JSONDictionary = [String:Any]
        
        let path = Bundle.main.path(forResource: "events", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            
            if let parsedData = try JSONSerialization.jsonObject(with: data) as? JSONDictionary,
            let events = parsedData["events"] as? [JSONDictionary] {
                for event in events {
                    print("event ", event["name"] as? String ?? "n/a")
                }
            }
                        if let parsedData = try JSONSerialization.jsonObject(with: data) as? JSONDictionary,let categories = parsedData["category"] as? [JSONDictionary] {
                for category in categories {
                    print("category ", category["name"] as? String ?? "n/a")
                }
            }
                        if let parsedData = try JSONSerialization.jsonObject(with: data) as? JSONDictionary,let places = parsedData["places"] as? [JSONDictionary] {
                for place in places {
                    print("place ", place["name"] as? String ?? "n/a")
                }
            }
            
        } catch {
            print(error)
        }
        

    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell
        
        //cell.eventTitle!.text = filteredEvents[indexPath.row].name
        //cell.eventCategory!.text = filteredEvents[indexPath.row].category
        
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
            filterButtonSeanceSpe.backgroundColor = UIColor.darkGray
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
            //filteredEvents = events.filter { $0.category == filter }
        }
        
        if activeFilters.isEmpty {
            filteredEvents = events
        }
        
        self.tableView.reloadData()
        
        print(filteredEvents)
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

// MARK : Filtre par jour

protocol dropDownProtocol {
    func dropDownPressed(string: String)
}

class dropDownBtn: UIButton, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        
        dropView = dropDownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            NSLayoutConstraint.activate([self.height])
            
            self.height.constant = self.dropView.tableView.contentSize.height
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func dismissDropDown(){
        isOpen = false
        
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}















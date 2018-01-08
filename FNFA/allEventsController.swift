//
//  allEventsController.swift
//  FNFA
//
//  Created by Robin Minervini on 30/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import UIKit
extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }
}

extension Date {
    
    var nameNumberDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d"
        return formatter.string(from: self)
    }
    var nameNumberMonthDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: self)
    }
    
    var hourDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

extension Notification.Name {
    static let reload = Notification.Name("reload")
}

class allEventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterSeancesSpe: UIButton!
    @IBOutlet weak var filterSalonDesEcritures: UIButton!
    
    @IBOutlet weak var filtersTrailingConstraint: NSLayoutConstraint!
    var isFiltersHidden = true
    var activeFilters = [String]()
    
    var button = dropDownBtn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)
        
        downloadJson {
            self.tableView.reloadData()
        }
        
        tableView.rowHeight = 110
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - Design filters button
        
        filtersTrailingConstraint.constant = 320
        
        filterSeancesSpe.backgroundColor = .clear
        filterSeancesSpe.layer.cornerRadius = 10
        filterSeancesSpe.layer.borderWidth = 2
        filterSeancesSpe.layer.borderColor = UIColor.black.cgColor
        
        filterSalonDesEcritures.backgroundColor = .clear
        filterSalonDesEcritures.layer.cornerRadius = 10
        filterSalonDesEcritures.layer.borderWidth = 2
        filterSalonDesEcritures.layer.borderColor = UIColor.black.cgColor
        
        // MARK: - DropDown button init
        
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Date", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        
        NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.topMargin, multiplier: 1.0, constant: 20.0).isActive = true
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //button.dropView.dropDownOptions =  ["Mercredi 4", "Jeudi 5", "Vendredi 6", "Samedi 7", "Dimanche 8"]
        button.dropView.dropDownOptions =  [String]()
        var initialDateDropDownOption = [String]()
        
        let formatter = ISO8601DateFormatter()
        for date in filteredEvents {
            let dateIso = date.startingDate
            if let date = formatter.date(from: dateIso) {
                if button.dropView.dropDownOptions.contains(date.nameNumberDate.capitalized) {
                } else {
                    button.dropView.dropDownOptions.append(date.nameNumberDate.capitalized)
                    initialDateDropDownOption.append(dateIso)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell
        
        cell.eventTitle!.text = filteredEvents[indexPath.row].name
        cell.eventCategory!.text = filteredEvents[indexPath.row].category
        
        let dateIso = filteredEvents[indexPath.row].startingDate
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withYear, .withMonth, .withDay, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        formatter.timeZone = TimeZone(identifier: "Europe/Paris")
        if let date = formatter.date(from: dateIso) {
            let string = date.hourDate
            cell.eventDate!.text = string
        }
        
        cell.eventPlace!.text = filteredEvents[indexPath.row].place.joined(separator: ", ")
        
        cell.eventTitle!.text = filteredEvents[indexPath.row].name
        
        var imageName = cell.eventTitle.text!.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        imageName = imageName.replacingOccurrences(of: "°", with: "", options: .literal, range: nil)
        imageName = imageName.replacingOccurrences(of: "é|è|ê", with: "e", options: .literal, range: nil)
        imageName = imageName.lowercased()
        
        cell.eventThumbnail!.image = UIImage(named:imageName)
        
        if cell.eventThumbnail!.image == nil {
            cell.eventThumbnail!.image = UIImage(named:"default")
        }
        
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
            filtersTrailingConstraint.constant = 320
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        isFiltersHidden = !isFiltersHidden
    }
    
    @IBAction func changeFilter (_ sender: UIButton) {
        if let index = activeFilters.index(of: (sender.titleLabel?.text)!) {
            
            activeFilters.remove(at: index)
            sender.backgroundColor = .clear
        } else {
            activeFilters.append((sender.titleLabel?.text)!)
            sender.backgroundColor = UIColor.darkGray
        }
        
        filterEvent()
    }
    
    func filterEvent(){
        
        // Gestion du cas où plusieurs filtres sont sélectionnés
        filteredEvents = events
        
        for filter in activeFilters {
            filteredEvents = filteredEvents.filter { $0.category == filter }
        }
        
        self.tableView.reloadData()
    }
    
    @objc func reloadTableData(_ notification: Notification) {
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
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let destination = segue.destination as? SingleEventViewController {
    //            destination.event = events[(tableView.indexPathForSelectedRow?.row)!]
    //        }
    //    }
    
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
        filteredEvents = events
        
        //2018-04-04T23:00:00Z
        //formatter.dateFormat = "EEEE d"
        
        let dateSource = dropDownOptions[indexPath.row]
        
        let stringFromDate = Date().iso8601    // "2017-03-22T13:22:13.933Z"
        
        if let dateFromString = stringFromDate.dateFromISO8601 {
            print(dateFromString.iso8601)      // "2017-03-22T13:22:13.933Z"
        }
    }
}















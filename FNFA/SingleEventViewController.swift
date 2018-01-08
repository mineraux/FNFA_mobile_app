//
//  SingleEventViewController.swift
//  FNFA
//
//  Created by Robin Minervini on 24/12/2017.
//  Copyright © 2017 Robin Minervini. All rights reserved.
//

import UIKit

class SingleEventViewController: UIViewController {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleSingleEventLabel: UILabel!
    
    
    var event:EventList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleSingleEventLabel.text = event?.name
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


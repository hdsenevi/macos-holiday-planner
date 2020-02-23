//
//  TripTapViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 23/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class TripTabViewController: NSTabViewController {

    var holiday: Holiday! {
        didSet {
            let detailsViewController = children[0] as! TripDetailsViewController
            detailsViewController.holiday = holiday
            
            let notesViewController = children[1] as! TripNoteViewController
            notesViewController.holiday = holiday
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

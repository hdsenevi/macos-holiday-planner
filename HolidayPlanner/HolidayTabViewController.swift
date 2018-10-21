//
//  HolidayTabViewController.swift
//  HolidayPlanner
//
//  Created by Sha on 21/10/18.
//  Copyright © 2018 Sha. All rights reserved.
//

import Cocoa

class HolidayTabViewController: NSTabViewController {

    var holiday: Holiday! {
        didSet {
            let detailsViewController = children[0] as? HolidayDetailsViewController
            detailsViewController?.holiday = holiday
            
            let notesViewController = children[1] as? HolidayNotesViewController
            notesViewController?.holiday = holiday
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

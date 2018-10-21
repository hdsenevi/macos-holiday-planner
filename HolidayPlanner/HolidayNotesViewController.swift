//
//  HolidayNotesViewController.swift
//  HolidayPlanner
//
//  Created by Sha on 19/10/18.
//  Copyright © 2018 Sha. All rights reserved.
//

import Cocoa

class HolidayNotesViewController: NSViewController {

    @IBOutlet var objectController: NSObjectController!
    
    var holiday: Holiday! {
        didSet {
            objectController.content = holiday
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

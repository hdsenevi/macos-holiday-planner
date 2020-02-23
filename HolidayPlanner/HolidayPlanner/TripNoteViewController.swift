//
//  TripNoteViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 19/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class TripNoteViewController: NSViewController {

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

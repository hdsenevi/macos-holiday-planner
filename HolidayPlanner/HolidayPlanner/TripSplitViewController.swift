//
//  TripSplitViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 23/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class TripSplitViewController: NSSplitViewController {

    @IBOutlet var tripArrayController: NSArrayController!
    
    var managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setInitialTrip() {
        do {
            tripArrayController.managedObjectContext = managedObjectContext
            try tripArrayController.fetch(with: nil, merge: false)
            
            if (tripArrayController.selectedObjects != nil) {
                let holiday = tripArrayController.selectedObjects[0] as! Holiday
                let tabViewController = children[1] as! TripTabViewController
                tabViewController.holiday = holiday
            }
        }
        catch {
            
        }
    }
    
}

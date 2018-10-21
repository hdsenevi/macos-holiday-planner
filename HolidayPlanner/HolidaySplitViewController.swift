//
//  HolidaySplitViewController.swift
//  HolidayPlanner
//
//  Created by Sha on 21/10/18.
//  Copyright © 2018 Sha. All rights reserved.
//

import Cocoa

class HolidaySplitViewController: NSSplitViewController {

    @IBOutlet var holidayArrayController: NSArrayController!
    
    var managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setInitialHoliday() {
        do {
            try holidayArrayController.fetch(with: nil, merge: false)
            
            if (holidayArrayController.selectedObjects != nil) {
                let holiday = holidayArrayController.selectedObjects[0] as! Holiday
                let tabViewController = children[1] as! HolidayTabViewController
                tabViewController.holiday = holiday
            }
        }
        catch {
            
        }
    }
    
}

//
//  TripSplitViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 23/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class TripSplitViewController: NSSplitViewController, TripListViewControllerDelegate {
    @IBOutlet var tripArrayController: NSArrayController!
    
    var managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let listViewController = children[0] as! TripListViewController
        listViewController.delegate = self
    }
    
    @IBAction func addHoliday(_ sender: Any)
    {
        let listViewController = children[0] as! TripListViewController
        listViewController.addHoliday(self)
    }
    
    // MARK: TripListViewControllerDelegate functions
    func selectHoliday(holiday: Holiday?) {
        let tabViewController = children[1] as! TripTabViewController
        tabViewController.holiday = holiday
    }
}

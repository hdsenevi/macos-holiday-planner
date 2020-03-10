//
//  TripDetailsViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 19/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class TripDetailsViewController: NSViewController {

    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    @IBOutlet weak var totalTimeLabel: NSTextField!
    
    @IBOutlet var objectController: NSObjectController!
    @IBOutlet var activitiesArrayController: NSArrayController!
    
    lazy var deteComponentsFormatter: DateComponentsFormatter = {
        let dateComponentsFormatter = DateComponentsFormatter()
        
        dateComponentsFormatter.allowedUnits = .day
        dateComponentsFormatter.unitsStyle = .full
        
        return dateComponentsFormatter
    }()
    
    var holiday: Holiday! {
        didSet {
            objectController.content = holiday
            activitiesArrayController.content = holiday.activities
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startDatePicker.dateValue = Date()
        self.endDatePicker.dateValue = Date()
        
        dateChanged(self.startDatePicker)
    }
    
    @IBAction func dateChanged(_ sender: NSDatePicker) {
        let cal = Calendar(identifier: .gregorian)
        let midnightStartDate = cal.startOfDay(for: self.startDatePicker.dateValue)
        
        // To make even days we go through midnight of the next day
        let midnightEndDate = cal.startOfDay(for: self.endDatePicker.dateValue).addingTimeInterval(60 * 60 * 24)
        
        let tripTime = midnightEndDate.timeIntervalSince(midnightStartDate)
        
        self.totalTimeLabel.stringValue = self.deteComponentsFormatter.string(from: tripTime)!
    }
    
    @IBAction func activitiesTableDoubleClick(_ sender: Any) {
        addActivity(sender)
    }
    
    @IBAction func addActivity(_ sender: Any) {
        let managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let activity = NSEntityDescription.insertNewObject(forEntityName: "Activity", into: managedObjectContext) as! Activity
        activity.holiday = holiday
        activitiesArrayController.addObject(activity)
    }
    
    @IBAction func removeActivity(_ sender: NSButton) {
        let managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for activity in activitiesArrayController.selectedObjects {
            managedObjectContext.delete(activity as! Activity)
        }
        
        activitiesArrayController.remove(contentsOf: activitiesArrayController.selectedObjects)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "phtoSegue") {
            let photosViewController = (segue.destinationController as! NSWindowController).contentViewController as! TripPhotosViewController
            photosViewController.holiday = holiday
        }
    }
}

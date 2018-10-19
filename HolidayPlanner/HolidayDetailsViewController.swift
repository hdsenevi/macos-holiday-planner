//
//  HolidayDetailsViewController.swift
//  HolidayPlanner
//
//  Created by Sha on 19/10/18.
//  Copyright © 2018 Sha. All rights reserved.
//

import Cocoa

class HolidayDetailsViewController: NSViewController {

    @IBOutlet weak var startDatePicker: NSDatePicker!
    @IBOutlet weak var endDatePicker: NSDatePicker!
    @IBOutlet weak var totalTimeLabel: NSTextField!
    
    lazy var dateComponentsFormatter: DateComponentsFormatter = {
        let dateComponentsFormatter = DateComponentsFormatter()
        
        dateComponentsFormatter.allowedUnits = .day
        dateComponentsFormatter.unitsStyle = .full
        
        return dateComponentsFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.startDatePicker.dateValue = Date()
        self.endDatePicker.dateValue = Date()
        
        dateChanged(self.startDatePicker)
    }
    
    @IBAction func dateChanged(_ sender: NSDatePicker) {
        let cal = Calendar(identifier: .gregorian)
        let midNightStartDate = cal.startOfDay(for: self.startDatePicker.dateValue)
        
        // To make even days, we go through midnight of the next day
        let midNightEndDate = cal.startOfDay(for: self.endDatePicker.dateValue).addingTimeInterval(60 * 60 * 24)
        
        let holidayTime = midNightEndDate.timeIntervalSince(midNightStartDate)
        
        self.totalTimeLabel.stringValue = self.dateComponentsFormatter.string(from: holidayTime)!
    }
}

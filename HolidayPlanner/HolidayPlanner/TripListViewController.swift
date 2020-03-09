//
//  TripListViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 19/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

protocol TripListViewControllerDelegate: class {
    func selectHoliday(holiday: Holiday?)
}
class TripListViewController: NSViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {

    weak var delegate: TripListViewControllerDelegate?
    @IBOutlet var holidayOutlineView: NSOutlineView!
    
    var groupedHolidays: Array<HolidayGroup> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        holidayOutlineView.expandItem(groupedHolidays.first)
        holidayOutlineView.expandItem(groupedHolidays.last)
        selectFirstHoliday()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadHolidays()
    }
    
    func loadHolidays() {
        do {
            let managedObejectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // confirm there is at least one holiday
            let holidaysFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Holiday")
            var allHolidays = try managedObejectContext.fetch(holidaysFetchRequest) as! [Holiday]
            
            if (allHolidays.count == 0) {
                let holiday = NSEntityDescription.insertNewObject(forEntityName: "Holiday", into: managedObejectContext) as! Holiday
                
                holiday.name = "Sample Holiday"
                holiday.startDate = Date()
                holiday.endDate = Date()
                
                allHolidays = [holiday]
            }
            
            let achivedHolidays = allHolidays.filter(){ $0.archived == true }
            let currentHolidays = allHolidays.filter(){ $0.archived == false }
            
            let currentGroup = HolidayGroup(groupName: "Current", groupHolidays: currentHolidays)
            let archivedGroup = HolidayGroup(groupName: "Archived", groupHolidays: achivedHolidays)
            
            groupedHolidays = [currentGroup, archivedGroup]
        }
        catch {
            // Problem fetching data
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let group = item as? HolidayGroup {
            return group.holidays.count
        } else {
            return groupedHolidays.count
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let group = item as? HolidayGroup {
            // If the current item is a holiday group, the child item is the holiday at the index
            return group.holidays[index]
        } else
        {
            // If the current item is not a holiday group, we are at the top level. Return the group at the index
            return groupedHolidays[index]
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        var expandable = false
        if let group = item as? HolidayGroup {
            expandable = group.holidays.count > 0
        }
        
        return expandable
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return item is Holiday
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NameCell"), owner: self) as? NSTableCellView
        
        if let textField = view?.textField
        {
            if let group = item as? HolidayGroup
            {
                textField.stringValue = group.name
            }
            else
            {
                let holiday = item as? Holiday
                if (holiday?.name != nil)
                {
                    textField.stringValue = (holiday?.name)!
                }
            }
        }
        
        return view
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        let holiday = holidayOutlineView.item(atRow: holidayOutlineView.selectedRow) as? Holiday
        delegate?.selectHoliday(holiday: holiday)
    }
    
    @IBAction func addHoliday(_ sender: Any) {
        let managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let holiday = NSEntityDescription.insertNewObject(forEntityName: "Holiday", into: managedObjectContext) as! Holiday
        
        holiday.name = "New holiday"
        holiday.startDate = Date()
        holiday.endDate = Date()
        
        refreshList()
        
        let holidayRow = holidayOutlineView.row(forItem: holiday)
        holidayOutlineView.selectRowIndexes(IndexSet.init(integer: holidayRow), byExtendingSelection: false)
    }
    
    @IBAction func removeHoliday(_ sender: NSButton) {
        if let holiday = holidayOutlineView.item(atRow: holidayOutlineView.selectedRow) as? Holiday
        {
            let alert: NSAlert = NSAlert()
            alert.messageText = "Are you sure you want to delete this holiday?"
            alert.informativeText = "Deleted holidays cannot be restored."
            alert.alertStyle = .informational
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Cancel")
            let confirmDelete = alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
            
            if confirmDelete {
                let managedObjectContect = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                managedObjectContect.delete(holiday)
                refreshList()
                selectFirstHoliday()
            }
        }
    }
    
    func refreshList()
    {
        loadHolidays()
        holidayOutlineView.reloadData()
        
        holidayOutlineView.expandItem(groupedHolidays.first)
        holidayOutlineView.expandItem(groupedHolidays.last)
    }
    
    func selectFirstHoliday()
    {
        let firstHoliday = groupedHolidays.first?.holidays.first
        let firstHolidayRow = holidayOutlineView.row(forItem: firstHoliday)
        
        if firstHolidayRow > -1
        {
            holidayOutlineView.selectRowIndexes(IndexSet.init(integer: firstHolidayRow), byExtendingSelection: false)
            // deletate?.selecHoliday(holiday: firstHoliday)
        }
    }
}

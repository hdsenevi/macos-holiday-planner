//
//  HolidayGroup.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 2/3/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class HolidayGroup: NSObject {
    var name: String
    var holidays: Array<Holiday>
    
    init(groupName: String, groupHolidays: Array<Holiday>) {
        name = groupName
        holidays = groupHolidays
        
        super.init()
    }
}

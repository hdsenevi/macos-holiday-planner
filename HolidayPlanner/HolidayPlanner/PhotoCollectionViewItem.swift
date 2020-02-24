//
//  PhotoCollectionViewItem.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 25/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class PhotoCollectionViewItem: NSCollectionViewItem {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.blue.cgColor
        view.layer?.borderWidth = 0
    }
    
    func updateForSelection() {
        view.layer?.borderWidth = isSelected ? 5 : 0
    }
    
}

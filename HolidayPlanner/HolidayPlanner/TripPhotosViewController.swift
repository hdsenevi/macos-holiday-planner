//
//  TripPhotosViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 25/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

class TripPhotosViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, AddPhotoViewControllerDelegate {

    @IBOutlet var collectionView: NSCollectionView!
    
    var holiday: Holiday!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return holiday.photos != nil ? holiday.photos!.count : 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        holiday.photos!.object(at: indexPath.item)
        let photo = holiday.photos!.object(at: indexPath.item) as! Photo
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PhotoCollectionViewItem"), for: indexPath)
        
        if (photo.photoData != nil) {
            item.imageView?.image = NSImage(data: photo.photoData as Data!)
        }
        else {
            item.imageView?.image = nil
        }
        
        if (photo.note != nil) {
            item.textField?.stringValue = photo.note!
        }
        else {
            item.textField?.stringValue = ""
        }
       
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, didChangeItemsAt indexPaths: Set<IndexPath>, to highlightState: NSCollectionViewItem.HighlightState) {
        for path in indexPaths {
            let selectedItem = collectionView.item(at: path) as! PhotoCollectionViewItem
            selectedItem.updateForSelection()
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addPhotoSegue") {
            (segue.destinationController as! AddPhotoViewController).delegate = self
        }
    }
    
    @IBAction func removePhotos(_ sender: NSButton) {
        let managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let selectedIndex = collectionView.selectionIndexes.first
        
        if (selectedIndex != nil) {
            let selectedPhoto = holiday.photos?.object(at: selectedIndex!) as! Photo
            managedObjectContext.delete(selectedPhoto)
            collectionView.deleteItems(at: collectionView.selectionIndexPaths)
        }
    }
    
    // MARK: AddPhotoViewControllerDelete functions
    func addPhoto(viewController: NSViewController, photoImage: NSImage?, name: String?, note: String?) {
        let managedObjectContext = (NSApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: managedObjectContext) as! Photo
        
        photo.photoData = photoImage?.tiffRepresentation as Data!
        photo.name = name
        photo.note = note
        
        holiday.addToPhotos(photo)
        
        collectionView.insertItems(at: [IndexPath.init(item: holiday.photos!.count - 1, section: 0)])
        
        self.dismiss(viewController)
    }
    
}

//
//  AddPhotoViewController.swift
//  HolidayPlanner
//
//  Created by Shanaka Senevirathne on 25/2/20.
//  Copyright © 2020 Shanaka Senevirathne. All rights reserved.
//

import Cocoa

protocol AddPhotoViewControllerDelegate: class {
    func addPhoto(viewController: NSViewController, photoImage: NSImage?, name: String?, note: String?)
}

class AddPhotoViewController: NSViewController {

    @IBOutlet weak var photoImageView: NSImageView!
    @IBOutlet weak var photoNameTextField: NSTextField!
    @IBOutlet weak var photoNoteTextField: NSTextField!
    
    weak var delegate: AddPhotoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addImage(_ sender: NSButton) {
        delegate?.addPhoto(viewController: self,
                           photoImage: photoImageView.image,
                           name: photoNameTextField.stringValue,
                           note: photoNoteTextField.stringValue)
    }
    
}

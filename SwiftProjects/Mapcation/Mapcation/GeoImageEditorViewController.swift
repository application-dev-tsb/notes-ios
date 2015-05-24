//
//  GeoImageEditorViewController.swift
//  Mapcation
//
//  Created by Lyndon Michael Bibera on 5/24/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit

class GeoImageEditorViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func reset(sender: UIBarButtonItem) {
    }
    
    @IBAction func setLocationUsingCurrent(sender: UIBarButtonItem) {
    }
    
    @IBAction func setImageFromGallery(sender: UIBarButtonItem) {
    }
}

//
//  MapcationViewController.swift
//  Mapcation
//
//  Created by Lyndon Michael Bibera on 5/24/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit
import MapKit

class MapcationViewController: UIViewController {
    
    @IBOutlet weak var backwardButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func switchFocusedImage(sender: UIBarButtonItem) {
        if sender == forwardButton {
            
        } else if sender == backwardButton {
            
        }
    }
    
    @IBAction func restartFocusedImage(sender: UIBarButtonItem) {
        sender.enabled = false
    }

    @IBAction func trashAllImages(sender: UIBarButtonItem) {
        sender.enabled = false
    }
}

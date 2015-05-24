//
//  GeoImageEditorViewController.swift
//  Mapcation
//
//  Created by Lyndon Michael Bibera on 5/24/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit
import CoreLocation

class GeoImageEditorViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    //MARK: - Variables
    
    lazy var locationManager: CLLocationManager = {
        var l = CLLocationManager()
        l.delegate = self
        return l;
    }()
    
    var location: CLLocation? {
        didSet {
            if location != nil {
                latitudeTextField.text = location?.coordinate.latitude.description
                longitudeTextField.text = location?.coordinate.longitude.description
            }
        }
    }
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        locationManager.stopUpdatingLocation()
    }

    //MARK: - Actions
    
    @IBAction func reset(sender: UIBarButtonItem) {
    }
    
    @IBAction func setLocationUsingCurrent(sender: UIBarButtonItem) {
        sender.enabled = false
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .Denied, .Restricted:
            latitudeTextField.text = ""
            longitudeTextField.text = ""
            location = nil
        }
    }
    
    @IBAction func setImageFromGallery(sender: UIBarButtonItem) {
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
        case .NotDetermined, .Denied, .Restricted:
            latitudeTextField.text = ""
            longitudeTextField.text = ""
            location = nil
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        location = newLocation
    }
    
}

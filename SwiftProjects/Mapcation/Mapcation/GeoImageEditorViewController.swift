//
//  GeoImageEditorViewController.swift
//  Mapcation
//
//  Created by Lyndon Michael Bibera on 5/24/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit
import CoreLocation

class GeoImageEditorViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var searchLocationButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
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
            refreshDoneStatus()
        }
    }
    
    let imagePicker = UIImagePickerController()
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        titleTextField.delegate = self
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
            showError(nil)
            locationManager.startUpdatingLocation()
        case .NotDetermined:
            showError(nil)
            locationManager.requestWhenInUseAuthorization()
        case .Denied:
            showError("ERROR: Denied")
        case .Restricted:
            showError("ERROR: Restricted")
        }
    }
    
    @IBAction func setImageFromGallery(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            imagePicker.sourceType = .SavedPhotosAlbum
            imagePicker.allowsEditing = false
            
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            showError("ERROR: Photo Album is not Accessible")
        }
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        if isValidGeoImage() {
            println("Image: \(imageView.image) Location:\(location) Text:\(titleTextField.text)")
        } else {
            refreshDoneStatus()
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        if let myImage = image {
            imageView.image = myImage
        }
        refreshDoneStatus()
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            showError(nil)
            manager.startUpdatingLocation()
        case .NotDetermined:
            showError(nil)
            manager.requestWhenInUseAuthorization()
        case .Denied:
            showError("ERROR: Denied")
        case .Restricted:
            showError("ERROR: Restricted")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        location = newLocation
        manager.stopUpdatingLocation()
        searchLocationButton.enabled = true
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        refreshDoneStatus()
    }
    
    //MARK: -
    
    private func isValidGeoImage() -> Bool {
        var isValid = true;
        
        if let titleTextIsEmpty = titleTextField.text?.isEmpty {
            isValid = !titleTextIsEmpty
        } else {
            isValid = false
        }
        
        if location == nil {
            isValid = false
        }
        
        if imageView.image == nil {
            isValid = false
        }
        
        return isValid
    }
    
    private func refreshDoneStatus() {
        doneButton.enabled = isValidGeoImage()
    }
    
    private func showError(error: String?) {
        if let message = error {
            errorLabel.text = message
            errorLabel.hidden = false
        } else {
            errorLabel.text = ""
            errorLabel.hidden = true
        }
    }
}

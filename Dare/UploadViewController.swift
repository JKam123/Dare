//
//  ViewController.swift
//  dare.app
//
//  Created by Ingunn Augdal Fløvig on 05/03/2017.
//  Copyright © 2017 Ingunn Augdal Fløvig. All rights reserved.
//

import UIKit
import MapKit

class UploadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let posterName = "Your account"
    let postDescriptionWhy = "Why are you giving away the food?"
    let postDescriptionWhat = "Please describe the food you are giving away and its current condition."
    let postMapkit = "Please pin the leaf to your location"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        loadImage()
        requestLocationAccess()
    }
    
    func loadImage(){
        topImageView.image = UIImage(named:"cat-pet-animal-domestic-104827")
        
    }
    
    func accessPhotosLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 3) {
            return 150.0
        } else {
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellTemplateName = ""
        if indexPath.row == 3 {
            cellTemplateName = "mapcell"
        }
        if indexPath.row == 0 {
            cellTemplateName = "UserName"
        }
        if indexPath.row == 1 {
            cellTemplateName = "TextCellEditor"
        }
        if indexPath.row == 2 {
            cellTemplateName = "TextCellEditor"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTemplateName, for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel!.text = posterName
            cell.imageView!.image = UIImage(named:"cat-pet-animal-domestic-104827")
            cell.imageView!.layer.cornerRadius = 20.0;
            cell.imageView!.clipsToBounds = true;
            
        } else if indexPath.row == 1 {
            cell.textLabel!.text = postDescriptionWhy
        } else if indexPath.row == 2 {
            cell.textLabel!.text = postDescriptionWhat
        } else if indexPath.row == 3 {
            if let label = cell.textLabel {
                label.removeFromSuperview()
            }
            let mapCell = cell as! MapTableViewCell
            mapCell.mapView.isUserInteractionEnabled = false
            self.mapView = mapCell.mapView
        }
        return cell
    }
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    func requestLocationAccess() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    weak var mapView: MKMapView?
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        if let mapView = mapView {
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("Auth changed")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.centerMapOnLocation(location: manager.location!)
        currentLocation = manager.location!
    }
    
    @IBAction func recenterPressed(_ sender: Any) {
        self.centerMapOnLocation(location: currentLocation)
    }
    
    @IBAction func foodButtonPressed(_ sender: Any) {
        print("food button pressed")
    }
    
}


extension UploadViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //Do something cool with the image
            //Don't be lazy go make your own views in storyboard
            let imageView = UIImageView(frame: self.view.frame)
            imageView.image = pickedImage
            self.view.addSubview(imageView)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}


class EditTableViewCell:UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
}





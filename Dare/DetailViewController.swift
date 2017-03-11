//
//  DetailViewController.swift
//  dare.app
//
//  Created by Ingunn Augdal Fløvig on 05/03/2017.
//  Copyright © 2017 Ingunn Augdal Fløvig. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var posterName = ""
    var postDescriptionWhy = ""
    var postDescriptionWhat = ""
    let postMapkit = "insert the map area here"
    let postReviews = ""
    var Coord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        loadImage()
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
        return 5
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
        } else {
            cellTemplateName = "UserName"
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
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(Coord,                                                                   2000 * 2.0, 2000 * 2.0)
            mapCell.mapView.setRegion(coordinateRegion, animated: true)
            
            
            let pointAnnotation = CustomPin()
            pointAnnotation.coordinate = Coord
            
            mapCell.mapView.addAnnotation(pointAnnotation)
            

            
            //mapCell.mapView
        } else if indexPath.row == 4 {
            cell.textLabel!.text = postReviews
        }
        return cell
    }
    
    @IBAction func foodButtonPressed(_ sender: Any) {
        print("food button pressed")
    }
    
}


extension DetailViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

class MapTableViewCell:UITableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  2000 * 2.0, 2000 * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        pinAnnotationView.image = UIImage(named: "Picture1[912].png")
        return pinAnnotationView
    }


}














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
    var ProfilePic: UIImage? = nil
    var FoodPic: UIImage? = nil
    var Poster: User? = nil
    var Timestamp = ""
    let postMapkit = "insert the map area here"
    let postReviews = ""
    var Coord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var PosterID = ""
    
    var DGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        loadInformation()
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadInformation(){
        FireBaseDataBase().getUser(ID: PosterID, completion: {[weak self](U: User) in
            self?.setLoadedData(U: U)
        })
        FireBaseDataBase().getFoodPicture(ID: PosterID, Timestamp: Timestamp, completion: {[weak self](I: UIImage) in
            self?.setTopPicture(I: I
            )
        })
    }
    
    func setLoadedData(U: User){
        ProfilePic = U.ProfilePic
        posterName = U.FirstName+" "+U.LastName
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }

    }
    
    func setTopPicture(I: UIImage){
        topImageView.image = I
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
        }
        else if (indexPath.row == 2) {
            return UITableViewAutomaticDimension
        }
        else if (indexPath.row == 1) {
            return UITableViewAutomaticDimension
        }

        else {
            return 40.0
        }
    }
    
    @objc(tableView:estimatedHeightForRowAtIndexPath:) func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 3) {
            return 150.0
        }
        else if (indexPath.row == 2) {
            return 150
        }
        else if (indexPath.row == 1) {
            return 150
        }
        else {
            return 40.0
        }

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellTemplateName = ""
        if indexPath.row == 3 {
            cellTemplateName = "mapcell"
        } else if indexPath.row == 0{
            cellTemplateName = "UserName"
        }
        else{
            cellTemplateName = "DetailCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTemplateName, for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel!.text = posterName
            cell.imageView!.image = ProfilePic
            cell.imageView!.layer.cornerRadius = 20.0;
            cell.imageView!.clipsToBounds = true;
            
        } else if indexPath.row == 1 {
            let dc = cell as! DetailTableViewCell
            dc.titleLabel.text = "Food Type"
            dc.subTitleLabel.text = postDescriptionWhy
        } else if indexPath.row == 2 {
            let dc = cell as! DetailTableViewCell
            dc.titleLabel!.text = "Description"
            dc.subTitleLabel.text = postDescriptionWhat

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














//
//  ViewController.swift
//  map
//
//  Created by Sohee Kim on 3/5/17.
//  Copyright © 2017 Sohee Kim. All rights reserved.
//

import UIKit
import MapKit



class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    //var pointAnnotation:CustomPin!
    //var pinvarotationView:MKPinAnnotationView!
    @IBOutlet var LongPressRecognizer: UILongPressGestureRecognizer!

    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager(locationManager, didChangeAuthorization: status)
            return
            
            
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        requestLocationAccess()
        super.viewDidLoad()
        mapView.delegate = self
        let DB = FireBaseDataBase()
        DB.loadLocations(completion: {[weak self](V: [Location]) in
            self?.setupMarkers(Locs: V)
        })
        //LongPressRecognizer.addTarget(<#T##target: Any##Any#>, action: Selector)

        
        
    }
    
    func setupMarkers(Locs: [Location]){
        for L in Locs{
            addMarker(Loc: L)
        }

    }
    
    func addMarker(Loc: Location){
        /*let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: Lat, longitude: Long)
        mapView.addAnnotation(annotation)*/
        
        let pointAnnotation = CustomPin()
        pointAnnotation.Data = Loc
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(Loc.langitude)!, longitude: Double(Loc.lattitude)!)
        pointAnnotation.title = Loc.name
        pointAnnotation.subtitle = Loc.description
        
        mapView.addAnnotation(pointAnnotation)
        


    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        let btn = UIButton(type: .detailDisclosure)
        pinAnnotationView.canShowCallout = true
        pinAnnotationView.rightCalloutAccessoryView = btn
        //pinAnnotationView.image = UIImage(named: "Picture1[912].png")
        return pinAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation! as! CustomPin
        print(String(describing: location.title) )
        
        
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        myVC.posterName = location.Data.name
        myVC.postDescriptionWhy = location.Data.description
        myVC.postDescriptionWhat = location.Data.description
        myVC.Coord = CLLocationCoordinate2D(latitude: Double(location.Data.langitude)!, longitude: Double(location.Data.lattitude)!)
        self.navigationController?.pushViewController(myVC, animated: true)
        
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        self.centerMapOnLocation(location: manager.location!)
        currentLocation = manager.location
    }
    @IBAction func recenterPressed(_ sender: Any) {
        self.centerMapOnLocation(location: currentLocation)
    }
    
    @IBAction func lonngPressed(sender: UIGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            let myVC = storyboard?.instantiateViewController(withIdentifier: "NewVC") as! UploadViewController
            self.navigationController?.pushViewController(myVC, animated: true)
        }
        
    }
    
    @IBAction func logoutPresed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Startup", bundle: nil)
        let mainController = storyboard.instantiateInitialViewController()
        self.present(mainController!, animated:true, completion:nil)
    }
}


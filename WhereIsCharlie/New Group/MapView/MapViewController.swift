//
//  ViewController.swift
//  ProjectSwift
//
//  Created by Tristan Luong on 17/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Asking the permission to the user
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        
        var currentLocation: CLLocation!
        let camera: GMSCameraPosition
        
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locationManager.location
            camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 15)
        } else {
            camera = GMSCameraPosition.camera(withLatitude: 48.849145, longitude: 2.389659100000017, zoom: 15)
        }
        
        mapView.camera = camera
        
        EventServices.default.getEvents(currentLocation: currentLocation, completion: {
            events in
            
            guard let id = events["id"] as? Int else {
                return
            }
            
            guard let location = events["location"] as? [String: Any],
                let longitude = location["lng"] as? Double,
                let latitude = location["lat"] as? Double
                else {
                    return
            }
            
            let marker = Marker(id: id, longitude: longitude, latitude: latitude)
            self.showMarkers(marker: marker)
            
        })
        self.mapView.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.touchPrintFav))
    }
    
    @objc func touchPrintFav() {
        let next = FavViewController.newInstance()
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    func showMarkers(marker: Marker){
        let m = marker
        m.position = CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longitude)
        m.map = mapView
        m.title = String(marker.id)
    }
}


extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Clicked on marker")
        
        let next = DescriptionViewController.newInstance(id: marker.title!)
        self.navigationController?.pushViewController(next, animated: true)
        
        return true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
}


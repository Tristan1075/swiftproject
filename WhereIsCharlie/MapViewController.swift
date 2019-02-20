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
            self.showMarkers(position: events)
            
        })
        self.mapView.delegate = self
    }
    
    
    func showMarkers(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.map = mapView
        
    }
}


extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Clicked on marker")
        
        let next = DescriptionViewController.newInstance()
        self.navigationController?.pushViewController(next, animated: true)
        
        return true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
}


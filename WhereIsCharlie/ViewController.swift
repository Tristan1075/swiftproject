//
//  ViewController.swift
//  WhereIsCharlie
//
//  Created by Tristan Luong on 20/12/2018.
//  Copyright © 2018 Tristan Luong. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Asking the permission to the user
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        var currentLocation: CLLocation!
        let camera: GMSCameraPosition
        
        // Depending on the answer of the user, we are declaring the initialRegion of the camera

        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locationManager.location
            camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 15)
        } else {
            camera = GMSCameraPosition.camera(withLatitude: 48.849145, longitude: 2.389659100000017, zoom: 15)
        }
        
        
        // Initializing the google map API
        
        GMSServices.provideAPIKey("AIzaSyCT0YVI63LkBtGaaW8s6DI7K0XLKwEkviQ")
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        
        let songKickToken = "Oou8ISnf2DeEzIa8"
        
        
        // Unique way i found to concatene without being too complex lol
        
        var requestLocation = "https://api.songkick.com/api/3.0/search/locations.json?location=geo:"
        requestLocation += String(currentLocation.coordinate.latitude)
        requestLocation += ","
        requestLocation += String(currentLocation.coordinate.longitude)
        requestLocation += "&apikey="
        requestLocation += songKickToken
        
        // https://api.songkick.com/api/3.0/search/locations.json?location=geo:48.849145,2.389659100000017&apikey=Oou8ISnf2DeEzIa8
    
        // Request API depending on our location
        
        /*
        print(res.1["metroArea"]["id"])
        var request = "https://api.songkick.com/api/3.0/metro_areas/"
        request += String(res.1["metroArea"]["id"])
        request += "/calendar.json?apikey="
        request += songKickToken
         */
        
        Alamofire.request(requestLocation).responseJSON { response in
            
            
            guard let json = response.result.value as? [String: Any],
            let resultsPage = json["resultsPage"] as? [String: Any],
            let results = resultsPage["results"] as? [String: Any],
            let location = results["location"] as? [[String: Any]]
            else {
                return
            }
            
            location.forEach { loc in
                let metroArea = loc["metroArea"] as? [String: Any]
                let id = metroArea!["id"] as! String

                var request = "https://api.songkick.com/api/3.0/metro_areas/"
                request += id
                request += "/calendar.json?apikey="
                request += songKickToken
                
                Alamofire.request(request).responseJSON { res in
                    print(res)
                }

            }
            
            
            /*
            if let json = response.data {
                do {
                    let data = try JSON(data: json)
            
                    let location = data["resultsPage"]["results"]["location"].compactMap({ res in
                        print(res.1["metroArea"]["id"])

                    })
                } catch let error as NSError {
                }
            }
 
            */
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        locationManager.stopUpdatingLocation()
    }
}


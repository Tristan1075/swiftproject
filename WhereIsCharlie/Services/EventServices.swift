//
//  EventServices.swift
//  ProjectSwift
//
//  Created by Tristan Luong on 19/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Alamofire
import GoogleMaps

public class EventServices {
    
    public static let `default` = EventServices()
    let songKickToken = "Oou8ISnf2DeEzIa8"
    
    private init() {
        
    }
    
    public func getEvents(currentLocation: CLLocation, completion: @escaping ([String: Any]) -> Void) {
        
        
        var requestLocation = "https://api.songkick.com/api/3.0/search/locations.json?location=geo:"
        requestLocation += String(currentLocation.coordinate.latitude)
        requestLocation += ","
        requestLocation += String(currentLocation.coordinate.longitude)
        requestLocation += "&apikey="
        requestLocation += songKickToken
        
        Alamofire.request(requestLocation).responseJSON { (response) in
            guard let json = response.result.value as? [String: Any],
                let resultsPage = json["resultsPage"] as? [String: Any],
                let results = resultsPage["results"] as? [String: Any],
                let location = results["location"] as? [[String: Any]]
                else {
                    return
            }
            
            location.forEach { loc in
                let metroArea = loc["metroArea"] as? [String: Any]
                let id = metroArea!["id"] as! Int
                
                var request = "https://api.songkick.com/api/3.0/metro_areas/"
                request += String(id)
                request += "/calendar.json?apikey="
                request += self.songKickToken
                
                Alamofire.request(request).responseJSON { res in
                    guard let json = res.result.value as? [String: Any],
                        let resultsPage2 = json["resultsPage"] as? [String: Any],
                        let results2 = resultsPage2["results"] as? [String: Any],
                        let events = results2["event"] as? [[String: Any]]
                        else {
                            return
                    }
                    events.forEach { event in
                        completion(event)
                    }
                }
            }
        }
    }
    
    
    public func getEventById(id: String, completion: @escaping ([String: Any]) -> Void) {
        var requestEvent = "https://api.songkick.com/api/3.0/events/"
        requestEvent += id
        requestEvent += ".json?apikey="
        requestEvent += songKickToken
        
        Alamofire.request(requestEvent).responseJSON { (response) in
            
            print(response)
        }
    }
}






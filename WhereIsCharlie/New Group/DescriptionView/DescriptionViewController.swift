//
//  DescriptionViewController.swift
//  WhereIsCharlie
//
//  Created by muriel durand on 12/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import GoogleMaps

class DescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    
    var id: String!
    
    class func newInstance(id: String) -> DescriptionViewController{
        let dvc = DescriptionViewController()
        dvc.id = id
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        EventServices.default.getEventById(id: id, completion: {
            eventResult in
            
            guard let resultsPage = eventResult["resultsPage"] as? [String: Any],
            let results = resultsPage["results"] as? [String: Any],
            let event = results["event"] as? [String: Any],
            let start = event["start"] as? [String: Any]
            else {
                    return
            }
            
            self.nom.text = event["displayName"] as? String
            self.type.text = event["type"] as? String
            self.date.text = start["date"] as? String
            self.time.text = start["time"] as? String
    
        })
    
    }
    
    
    @IBAction func Lieux(_ sender: UITextField) {
    }
    @IBAction func Longitude(_ sender: UITextField) {
    }
    @IBAction func Latitude(_ sender: UITextField) {
    }
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Commentaire: UITableView!
    

}

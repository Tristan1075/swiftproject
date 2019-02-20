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
    
    
    var id: String!
    
    class func newInstance(id: String) -> DescriptionViewController{
        let dvc = DescriptionViewController()
        dvc.id = id
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        EventServices.default.getEventById(id: id, completion: {
            event in
            
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

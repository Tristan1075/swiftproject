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
    
    
    var position: CLLocationCoordinate2D!
    
    class func newInstance(position: CLLocationCoordinate2D) -> DescriptionViewController{
        let dvc = DescriptionViewController()
        dvc.position = position
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        print(position.longitude)
        // Do any additional setup after loading the view.
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

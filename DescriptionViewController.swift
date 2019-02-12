//
//  DescriptionViewController.swift
//  WhereIsCharlie
//
//  Created by muriel durand on 12/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    /*let metroArea = loc["metroArea"] as? [String: Any]
    let id = metroArea!["id"] as! Int
    let songKickToken = "Oou8ISnf2DeEzIa8"
    var request = "https://api.songkick.com/api/3.0/metro_areas/"
    request += String(id)
    request += "/calendar.json?apikey="
    request += songKickToken$/
    
//Alamofire.request(request)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

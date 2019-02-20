//
//  DescriptionViewController.swift
//  WhereIsCharlie
//
//  Created by muriel durand on 12/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    
    class func newInstance() -> DescriptionViewController{
        let dvc = DescriptionViewController()
        return dvc
    }

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
    

}

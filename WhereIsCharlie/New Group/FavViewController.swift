//
//  FavViewController.swift
//  WhereIsCharlie
//
//  Created by muriel durand on 20/02/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import Alamofire

class FavViewController: UIViewController {
    
    class func newInstance() -> FavViewController{
        let dvc = FavViewController()
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request("http://127.0.0.1:3000/api/events").responseJSON {(res) in
            
            guard let event = res.result.value as? [String:Any]
                else {
                    return
            }
            print(event)
           
        }

    }


}

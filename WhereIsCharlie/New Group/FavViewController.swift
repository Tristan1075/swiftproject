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
    
    @IBOutlet weak var tableView: UITableView!
    
    class func newInstance() -> FavViewController{
        let dvc = FavViewController()
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self as! UITableViewDelegate
        self.tableView.dataSource = self as! UITableViewDataSource
        self.tableView.register(UINib(nibName: "FavViewController", bundle: nil), forCellReuseIdentifier: FavViewController)
        
        
        Alamofire.request("http://127.0.0.1:3000/api/favorites").responseJSON {(res) in
            
            guard let favorites = res.result.value as? [[String : Any]]
            else {
                return
            }
            
            favorites.forEach({ favorite in
                EventServices.default.getEventById(id: favorite["idEvent"] as! String, completion: {
                    eventResult in
                    guard let resultsPage = eventResult["resultsPage"] as? [String: Any],
                        let results = resultsPage["results"] as? [String: Any],
                        let event = results["event"] as? [String: Any]
                        else {
                            return
                    }
                    print(event)
                })
            })
            
           
        }

    }


}

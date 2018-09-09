//
//  SearchResultsViewController.swift
//  Prueba_Liverpool
//
//  Created by Delberto Martinez on 9/9/18.
//  Copyright © 2018 Delberto Martinez. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = UserDefaults.standard
    var finalArray = [String]()
   
    private let cellIdentifier = "BusquedaTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        

          finalArray = defaults.stringArray(forKey: "savedSearchArray") ?? [String]()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         finalArray = defaults.stringArray(forKey: "savedSearchArray") ?? [String]()
        
        self.tableView.reloadData()
    
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return finalArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! BusquedaTableViewCell
   
        cell.searchLabel.text = finalArray[indexPath.row]
        
        return cell
    }
    
}

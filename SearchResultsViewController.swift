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
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultSaved.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! BusquedaTableViewCell
        
    let result = searchResultSaved[indexPath.row]
        
        cell.searchLabel.text =   result.value(forKeyPath: "result") as? String
        
        return cell
    }
    
}

//
//  ViewController.swift
//  Prueba_Liverpool
//
//  Created by Delberto Martinez on 9/9/18.
//  Copyright © 2018 Delberto Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
     private let cellIdentifier = "TableViewCell"
    var liverpoolData : [LiverpoolData] = [LiverpoolData]()
  
      var currentTextField: UITextField?
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var producto: String = ""
    var searchResult = APIManager.sharedInstance.searchResult
    override func viewDidLoad() {
        super.viewDidLoad()
   
        txtField.layer.borderColor = UIColor.purple.cgColor
        txtField.layer.borderWidth = 1.0
        self.activity.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
 
        }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        producto = ""
        currentTextField = textField
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        currentTextField?.resignFirstResponder()
        textField.resignFirstResponder()
        currentTextField = nil
        
        producto = self.txtField.text!
        
        self.searchResult.append(producto)
        
        let defaults = UserDefaults.standard
        defaults.set(self.searchResult, forKey: "savedSearchArray")
        
        
        activity.isHidden = false
        activity.startAnimating()
        self.view.isUserInteractionEnabled = false
        APIManager.sharedInstance.getProducts(product: producto, onSuccess: { json in
            DispatchQueue.main.async {
                
                self.liverpoolData = json.data
                
                self.tableView.reloadData()
                
                self.activity.isHidden = true
                self.activity.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
            
        })
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return liverpoolData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! TableViewCell
    
        cell.productName.text = liverpoolData[indexPath.row].product_displayName
        cell.productImage.downloadImageSync(downloadURL: liverpoolData[indexPath.row].sku_thumbnailImage, completion: { result in
            
        })
        cell.productPrice.text = liverpoolData[indexPath.row].maximumListPrice
        
        return cell
    }
   


}


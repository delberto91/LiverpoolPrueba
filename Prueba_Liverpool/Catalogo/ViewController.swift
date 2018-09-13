//
//  ViewController.swift
//  Prueba_Liverpool
//
//  Created by Delberto Martinez on 9/9/18.
//  Copyright © 2018 Delberto Martinez. All rights reserved.
//

import UIKit
import CoreData
var searchResultSaved : [NSManagedObject] = []
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
     private let cellIdentifier = "TableViewCell"
    var liverpoolData : [LiverpoolData] = [LiverpoolData]()
  
      var currentTextField: UITextField?
    var searchResult = APIManager.sharedInstance.searchResult
 
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var producto: String = ""
    
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
      
 
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Search")
        
        //3
        do {
            searchResultSaved = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error. \(error), \(error.userInfo)")
        }
        
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
        
        
        saveTheSearch(result: producto)
        
     
        
        
        activity.isHidden = false
        activity.startAnimating()
        self.view.isUserInteractionEnabled = false
        APIManager.sharedInstance.getProducts(product: producto, onSuccess: { json in
            DispatchQueue.main.async {
              // self.liverpoolData = []
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return liverpoolData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! TableViewCell

        cell.productName.text = liverpoolData[indexPath.row].product_displayName[indexPath.row]
        
        cell.productImage.downloadImageSync(downloadURL: liverpoolData[indexPath.row].sku_thumbnailImage[indexPath.row], completion:{ result in
            
        })
        
        cell.productPrice.text = liverpoolData[indexPath.row].maximumListPrice[indexPath.row]
        
        return cell
    }
   
    func saveTheSearch(result: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Search",
                                       in: managedContext)!
        
        let search = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        search.setValue(result, forKeyPath: "result")
        
        // 4
        do {
            try managedContext.save()
            searchResultSaved.append(search)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    }




//
//  APIManager.swift
//  Prueba_Liverpool
//
//  Created by Delberto Martinez on 9/9/18.
//  Copyright © 2018 Delberto Martinez. All rights reserved.
//

import UIKit
import SwiftyJSON
class APIManager: NSObject {
    
    static let sharedInstance = APIManager()
var searchResult = [String]()
    
    func getProducts(product: String, onSuccess: @escaping(LiverpoolResponse) -> Void) {
        
        let liverpoolResponse : LiverpoolResponse = LiverpoolResponse()
        
        guard let url = URL(string: "https://www.liverpool.com.mx/tienda?s=\(product)&d3106047a194921c01969dfdec083925=json") else {return}
        var  request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let response = response {
                
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>
                    
                    let result = try JSON(data: data)
                    if  let contents = json["contents"] as? [[String:AnyObject]] {
                        
                        let liverpoolData: LiverpoolData = LiverpoolData()
                        for mainContent in contents {
                            var mainContent = mainContent["mainContent"] as! [[String:AnyObject]]
                            
                            for contentFor in mainContent {
                                if let  content = contentFor["contents"] as? [[String:AnyObject]] {
                                    
                                    for record in content {
                                        if  let  records = record["records"] as? [[String:AnyObject]] {
                                            
                                            for att in records {
                                                let attributes = att["attributes"] as! Dictionary<String,AnyObject>
                                                
                                                if let thumbnailImage = attributes["sku.thumbnailImage"] as? [String] {
                                                    
                                                    for image in thumbnailImage{
                                                        
                                                        liverpoolData.sku_thumbnailImage.append(image)
                                                        
                                                        if let maximumListPrice = attributes["maximumListPrice"] as?  [String]{
                                                            
                                                            for maximumListPrice in maximumListPrice {
                                                                
                                                                liverpoolData.maximumListPrice.append(maximumListPrice)
                                                                
                                                                if let productDisplayName = attributes["product.displayName"] as? [String] {
                                                                    
                                                                    for product in productDisplayName {
                                                            
                                                                        liverpoolData.product_displayName.append(product)
                                                                        
                                                                        liverpoolResponse.data.append(liverpoolData)
                                                                    }
                                                                    
                                                                }
                                                                
                                                            
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                              
                            }
                            
                        }
                        //computadoras
                        
                    }
                    
                    
                    onSuccess(liverpoolResponse)
                } catch {
                    onSuccess(liverpoolResponse)
                }
            }
            if(error != nil){
                onSuccess(liverpoolResponse)
            } else{
            }
        })
        task.resume()
    }
    
}


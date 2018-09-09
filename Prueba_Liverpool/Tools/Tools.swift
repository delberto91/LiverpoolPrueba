//
//  Tools.swift
//  Prueba_Liverpool
//
//  Created by Delberto Martinez on 9/9/18.
//  Copyright © 2018 Delberto Martinez. All rights reserved.
//

import UIKit

class Tools: NSObject {
    

}
extension Array {
public  func flattenedArray(array:[Any]) -> [String] {
    var myArray = [String]()
    for element in array {
        if let element = element as? String {
            myArray.append(element)
        }
        if let element = element as? [Any] {
            let result = flattenedArray(array: element)
            for i in result {
                myArray.append(i)
            }
            
        }
    }
    return myArray
}
}
extension UIImageView {
public func downloadImageSync(downloadURL : String, completion: @escaping (Bool?) -> ()) {
    
    
    if (self.image == nil){
        self.image = UIImage(named: "profileDefault")
    }
    //let imageSufix =  "profile-" + userAppfterId
    //self.image = UIImage(named: "profileDefault")
    let fullNameArr : [String] = downloadURL.components(separatedBy: "/")
    let imageSufix =  fullNameArr.count > 1 ? fullNameArr[fullNameArr.count - 1] : nil
    
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let filePath = documentsURL.appendingPathComponent("rutina-\(imageSufix)")
    if FileManager.default.fileExists(atPath: filePath.path) {
        
        self.image = UIImage(contentsOfFile: filePath.path)
        
    }else{
        if(downloadURL != ""){
            URLSession.shared.dataTask(with: URL(string: downloadURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, completionHandler: { (data, response, error) -> Void in
                guard
                    let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                    let data = data , error == nil,
                    let imageLocal = UIImage(data: data)
                    else {
                        
                        
                        /*let fbUrl = "https://graph.facebook.com/" + fbId + "/picture?type=large"
                         
                         URLSession.shared.dataTask(with: URL(string: fbUrl)!, completionHandler: { (data, response, error) -> Void in
                         guard
                         let httpURLResponse = response as? HTTPURLResponse , httpURLResponse.statusCode == 200,
                         let mimeType = response?.mimeType , mimeType.hasPrefix("image"),
                         let data = data , error == nil,
                         let imageLocal = UIImage(data: data)
                         else { completion(true)
                         return }
                         DispatchQueue.main.async { () -> Void in
                         self.image = imageLocal
                         completion(true)
                         }
                         }).resume()*/
                        
                        completion(true)
                        return
                }
                
                
                DispatchQueue.main.async { () -> Void in
                    
                    do {
                        try data.write(to:filePath)
                        
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    self.image =  imageLocal
                    completion(true)
                    
                    
                    
                    
                }
            }).resume()
        }else{
            completion(true)
        }
    }
}
}

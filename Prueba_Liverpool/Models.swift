//
//  Models.swift
//  Prueba_Liverpool
//
//  Created by Delberto Martinez on 9/9/18.
//  Copyright © 2018 Delberto Martinez. All rights reserved.
//

import Foundation

open class LiverpoolResponse {
    
    var data : [LiverpoolData] = [LiverpoolData]()
}

open class LiverpoolData  {
    
    var maximumListPrice : [String] = []
    var product_displayName:  [String] = []
    var sku_thumbnailImage: [String] = []

}



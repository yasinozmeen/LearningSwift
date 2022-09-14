//
//  Model.swift
//  ByteCoin
//
//  Created by Kadir Yasin Özmen on 14.09.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel:Codable{
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Float
}

    

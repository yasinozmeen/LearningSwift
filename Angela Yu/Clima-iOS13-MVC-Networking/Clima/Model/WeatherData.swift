//
//  WeatherData.swift
//  Clima
//
//  Created by Kadir Yasin Özmen on 11.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct WeatherData:Decodable{
    let name: String
    let main: Main
    let weather: [weather]
}

struct Main:Decodable{
    let temp: Double
}

struct weather:Decodable{
    let id: Int
}

//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=2F9F5589-3D63-4A95-BD81-DBDEA83B8A13"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency:String){
        print(currency)
    }
    
    func fetchPrice(url:String){
        
        print("1")
        if let url = URL(string: url){
            print("2")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                print("3")
                if error != nil{
                    print(error)
                }else{
                    if let safeData = data{
                        print(String(data: safeData, encoding: .utf8)!)
                    }
                    
                }
            }
            task.resume()
        }
        
    }
}

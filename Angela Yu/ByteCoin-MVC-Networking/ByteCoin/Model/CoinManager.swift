//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerProtocol{
    func didUpdateUi(coin:CoinModel)
    func didFailWithError(error:Error)
}

struct CoinManager {
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerProtocol?
    
    func getCoinPrice(for currency:String){
        let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=2F9F5589-3D63-4A95-BD81-DBDEA83B8A13"
        fetchPrice(url: baseURL)
    }
    
    func fetchPrice(url:String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                }else{
                    if let safeData = data{
                       parseJson(safeData)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJson(_ data:Data){
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let base = decodeData.asset_id_base
            let quote = decodeData.asset_id_quote
            let rate = Float(String(format: "%.2f", decodeData.rate))!
            let coin = CoinModel(asset_id_base: base, asset_id_quote: quote, rate: rate)
            delegate?.didUpdateUi(coin: coin)
            print(coin)
        }catch{
            delegate?.didFailWithError(error: error)
        }
    }
}

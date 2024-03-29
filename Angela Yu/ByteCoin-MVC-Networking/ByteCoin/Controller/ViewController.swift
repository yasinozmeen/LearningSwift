//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var currencvLabel: UILabel!
    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!
    
    var coinManeger = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManeger.delegate = self
    }
}
//MARK: - pickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManeger.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManeger.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCoin = coinManeger.currencyArray[row]
        coinManeger.getCoinPrice(for: selectedCoin)
    }
}
//MARK: - CoinManegerProtocol
extension ViewController: CoinManagerProtocol{
    func didUpdateUi(coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencvLabel.text = coin.asset_id_quote
            self.bitcoinLabel.text = String(coin.rate)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

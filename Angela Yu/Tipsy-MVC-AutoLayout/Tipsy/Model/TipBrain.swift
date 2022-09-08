//
//  TipBrain.swift
//  Tipsy
//
//  Created by Kadir Yasin Özmen on 8.09.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct TipBrain{
    
    func calculateTip(bill:Float,split:Float,selectTip:Int) -> String{
        var multiplicationValue = 0.0
        if selectTip == 0{
            multiplicationValue = Double(Float(0)/Float(100))
        }
        if selectTip == 10{
            multiplicationValue = Double(Float(10)/Float(100))
        }
        if selectTip == 20{
            multiplicationValue = Double(Float(20)/Float(100))
        }
        return String(format: "%.2f", (bill+bill*Float(multiplicationValue))/split)
    }
}

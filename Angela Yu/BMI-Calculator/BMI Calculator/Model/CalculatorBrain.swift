//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Kadir Yasin Özmen on 7.09.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain{
    
    var bmi: BMI?
    
    mutating func calculateBmi(weight:Float,height:Float){
        let bmiValue = weight/pow(height, 2)
        
        if bmiValue < 18.5{
            bmi = BMI(bmiValue: bmiValue, adviceText: "Eat some pies", color: .blue)
        }else if bmiValue < 24.9{
            bmi = BMI(bmiValue: bmiValue, adviceText: "fit as a fiddle", color: .green)
        }else{
            bmi = BMI(bmiValue: bmiValue, adviceText: "eat less pies", color: .red)
        }
        
    }
    
    func getBMIValue()->String{
        return String(format: "%.1f",bmi?.bmiValue ?? 0.0)
    }
    func getColor()->UIColor{
        return bmi?.color ?? .black
    }
    func getAdvice()->String{
        return bmi?.adviceText ?? "some error"
    }
}

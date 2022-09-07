//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Kadir Yasin Özmen on 7.09.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var bmiValue: UILabel!
    @IBOutlet var adviceLabel: UILabel!
    @IBOutlet var resultBackgraundColor: UIImageView!
    
    var bmivalue: String?
    var bmiAdvice:String?
    var bmiColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let value = bmivalue, let color = bmiColor, let advice = bmiAdvice{
            bmiValue.text = value
            adviceLabel.text = advice
            resultBackgraundColor.backgroundColor = color
            
        }
    }
    @IBAction func reCalculate(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

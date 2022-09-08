//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Kadir Yasin Özmen on 8.09.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var settingsLabel: UILabel!
    
    var totalPerPerson: String?
    var split: Int?
    var tip: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = split, let tip = tip, let total = totalPerPerson {
            settingsLabel.text = "Split between \(split) people, with \(tip)% tip."
            totalLabel.text = total
        }
        
        
    }
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

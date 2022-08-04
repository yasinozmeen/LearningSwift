//
//  detayViewController.swift
//  SozlukUygulaması
//
//  Created by Kadir Yasin Özmen on 28.07.2022.
//

import UIKit

class detayViewController: UIViewController {

    
    var gelenKelime:Kelimeler?
    
    @IBOutlet var inglizceLabel: UILabel!
    @IBOutlet var turkceLAbel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
            turkceLAbel.text = gelenKelime?.turkce!
            inglizceLabel.text = gelenKelime?.ingilizce!
        
        
    }


}


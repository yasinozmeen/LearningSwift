//
//  KelimeDetayViewController.swift
//  URLSessionSozlukUygulamasi
//
//  Created by Kadir Yasin Özmen on 6.08.2022.
//

import UIKit

class KelimeDetayViewController: UIViewController {
    @IBOutlet weak var ingilizceLabel: UILabel!
    
    @IBOutlet weak var turkceLabel: UILabel!
    
    var kelime:Kelimeler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kelime {
            ingilizceLabel.text = k.ingilizce
            turkceLabel.text = k.turkce
        }

    }

}

//
//  KisiDetayViewController.swift
//  45.Uygulama-CoreDataKisilerUygulaması
//
//  Created by Kadir Yasin Özmen on 18.07.2022.
//

import UIKit

class KisiDetayViewController: UIViewController {
    @IBOutlet var kisiAdLabel: UILabel!
    @IBOutlet var kisiNoLabel: UILabel!
    
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kisiAdLabel.text = kisi?.kisi_ad
        kisiNoLabel.text = kisi?.kisi_tel
  
    }
    


}

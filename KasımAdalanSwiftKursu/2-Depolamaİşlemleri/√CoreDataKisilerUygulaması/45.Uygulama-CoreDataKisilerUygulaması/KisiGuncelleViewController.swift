//
//  KisiGuncelleViewController.swift
//  45.Uygulama-CoreDataKisilerUygulaması
//
//  Created by Kadir Yasin Özmen on 18.07.2022.
//

import UIKit

class KisiGuncelleViewController: UIViewController {
    @IBOutlet var kisiAdıTExtField: UITextField!
    @IBOutlet var kisiNumarasıTextField: UITextField!
    
    var kisi:Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kisiAdıTExtField.text = kisi?.kisi_ad
        kisiNumarasıTextField.text = kisi?.kisi_tel
    }
    @IBAction func kisiGuncelleButton(_ sender: Any) {
        
        self.kisi?.kisi_ad = kisiAdıTExtField.text
        self.kisi?.kisi_tel = kisiNumarasıTextField.text
        
        appDelegate.saveContext()
    }
    
}

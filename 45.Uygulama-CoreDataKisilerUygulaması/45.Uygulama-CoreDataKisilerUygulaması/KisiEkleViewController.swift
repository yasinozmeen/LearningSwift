//
//  KisiEkleViewController.swift
//  45.Uygulama-CoreDataKisilerUygulaması
//
//  Created by Kadir Yasin Özmen on 18.07.2022.
//

import UIKit

class KisiEkleViewController: UIViewController {

    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet var kisiAdıTextField: UITextField!
    @IBOutlet var kisiNumarasıTextField: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    @IBAction func kisiEkleButton(_ sender: Any) {
        let kisi = Kisiler(context: context)
        
        kisi.kisi_ad = kisiAdıTextField.text
        kisi.kisi_tel = kisiNumarasıTextField.text
        
        appDelegate.saveContext()
        kisiNumarasıTextField.text = ""
        kisiAdıTextField.text = ""
        
    }
    
}

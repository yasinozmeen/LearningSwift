//
//  anaSayfaVC.swift
//  43.Uygulama-LoginEkraniUserDefault
//
//  Created by Kadir Yasin Özmen on 14.07.2022.
//

import UIKit

class anaSayfaVC: UIViewController {
    @IBOutlet var label: UILabel!
    
    let d = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        let ka = d.string(forKey: "kullaniciAdi") ?? "bos"
        label.text = ka
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYapBarButton(_ sender: Any) {
        d.removeObject(forKey: "kullaniciAdi")
        d.removeObject(forKey: "sifre")
        
        exit(-1)
    }
    
 

}

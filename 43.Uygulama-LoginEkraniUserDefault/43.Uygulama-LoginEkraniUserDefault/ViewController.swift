//
//  ViewController.swift
//  43.Uygulama-LoginEkraniUserDefault
//
//  Created by Kadir Yasin Özmen on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var kullaniciAdiTextField: UITextField!
    @IBOutlet var sifreTextField: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var buttonName: UIButton!
    
    let d = UserDefaults.standard
    var kullaniciYokMu = true
    var kullaniciAdi = String()
    var sifre = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ka = d.string(forKey: "kullaniciAdi") ?? "bos"
        let s = d.string(forKey: "sifre") ?? "bos"
        
        if ka != "bos" && s != "bos" {
            performSegue(withIdentifier: "anasayfaGecis", sender: nil)
            label.isHidden = true
        }else{
            label.text = "Lütfen Kullanıcı Adı-Şifre Giriniz"
            label.isHidden = false
        }
        
        
    }
    @IBAction func girisYapButton(_ sender: Any) {
        if kullaniciYokMu{
            if let tempKA = kullaniciAdiTextField.text, let tempS = sifreTextField.text {// kullanıcı oluşturuldu
                kullaniciAdi = tempKA
                sifre = tempS
                kullaniciYokMu = false
                kullaniciAdiTextField.text = ""
                sifreTextField.text = ""
                if !kullaniciYokMu{
                    buttonName.setTitle("Giriş yap", for: .normal)
                }
            }
        }else{
            
            if let ka = kullaniciAdiTextField.text , let s = sifreTextField.text{
                
                if ka == kullaniciAdi && s == sifre {
                    d.set(ka, forKey: "kullaniciAdi")
                    d.set(s, forKey: "sifre")
                    
                    performSegue(withIdentifier: "anasayfaGecis", sender: nil)
                }else{
                    label.text = "Hatalı Giriş"
                    label.isHidden = false
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
}



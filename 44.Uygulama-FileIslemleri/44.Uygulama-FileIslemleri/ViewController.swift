//
//  ViewController.swift
//  44.Uygulama-FileIslemleri
//
//  Created by Kadir Yasin Özmen on 15.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var resimTutucu: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func yaz(_ sender: Any) {
        let mesaj = textField.text!
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let dosyaYolu = dir.appendingPathComponent("dosyam.txt")
            
            do {
                try mesaj.write(to: dosyaYolu, atomically: false, encoding: String.Encoding.utf8)
            }
            catch{ print("hataOldu")}
        }
    }
    @IBAction func oku(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let dosyaYolu = dir.appendingPathComponent("dosyam.txt")
            
            do {
                textField.text =  try String(contentsOf: dosyaYolu, encoding: .utf8)
            }
            catch { print("2HataOldu")}
        }
    }
    @IBAction func sil(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let dosyaYolu = dir.appendingPathComponent("dosyam.txt")
            
            if FileManager.default.fileExists(atPath: dosyaYolu.path){
                
                do{
                    try FileManager.default.removeItem(at: dosyaYolu)
                    textField.text = ""
                }
                catch{print("3HataOldu") }
            }
        }
    }
    @IBAction func resmiKaydet(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let dosyaYolu = dir.appendingPathComponent("batman.jpg")
            
            let resmim = UIImage(named: "batman")
            
            do{
                try resmim!.pngData()?.write(to: dosyaYolu)
            }
            catch{ }
        }
    }
    @IBAction func resmiGöster(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let dosyaYolu = dir.appendingPathComponent("batman.jpg")
            
            self.resimTutucu.image = UIImage(contentsOfFile: dosyaYolu.path)
        }
    }
    @IBAction func resmiSil(_ sender: Any) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let dosyaYolu = dir.appendingPathComponent("batman.jpg")
            
            if FileManager.default.fileExists(atPath: dosyaYolu.path){
                do{
                    try FileManager.default.removeItem(at: dosyaYolu)
                }
                catch { }
            }
        }
    }
    

}


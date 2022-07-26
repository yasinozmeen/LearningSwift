//
//  ViewController.swift
//  46.Uygulama-SQLiteUygulamalari
//
//  Created by Kadir Yasin Özmen on 25.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       veritabanıKopyala()
        
        
    
        
        
        let gelenListe = KisilerDao().rasgele2Kisi()
        for k in gelenListe{
            print("Kisi id:\(k.kisi_id!)--Kisi Ad:\(k.kisi_ad!)--Kisi Yas:\(k.kisi_yas!)")
        }
    }

    func veritabanıKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "kisilergiris", ofType: ".db")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManeger = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisilergiris.db")
        
        if fileManeger.fileExists(atPath: kopyalanacakYer.path){
            print("veritabanı zaten kayıtlı")
        }else{
            do{
                try fileManeger.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error)
            }
        }
    }
    
}


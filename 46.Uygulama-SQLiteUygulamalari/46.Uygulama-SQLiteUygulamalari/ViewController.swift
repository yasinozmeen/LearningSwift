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
        // Do any additional setup after loading the view.
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


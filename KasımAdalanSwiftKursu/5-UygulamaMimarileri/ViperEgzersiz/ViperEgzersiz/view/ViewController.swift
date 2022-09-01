//
//  ViewController.swift
//  ViperEgzersiz
//
//  Created by Kadir Yasin Özmen on 10.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var islemSegmented: UISegmentedControl!
    @IBOutlet var sayi1TextField: UITextField!
    @IBOutlet var sayi2TextField: UITextField!
    @IBOutlet var sonucLAbel: UILabel!
    
    var presenterNesnesi:ViewToPresenterProtocol?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router.createModule(ref: self)
    }


    @IBAction func hesaplaButton(_ sender: Any) {
        
        if let sayi1 = sayi1TextField.text, let sayi2 = sayi2TextField.text{
            
                switch islemSegmented.selectedSegmentIndex {
                case 0:
                    presenterNesnesi?.toplamaYap(sayi1: sayi1, sayi2: sayi2)
                    print("toplam")
                case 2:
                    presenterNesnesi?.carpmaYap(sayi1: sayi1, sayi2: sayi2)
                    print("çarpım")
                case 1:
                    presenterNesnesi?.cikarmaYap(sayi1: sayi1, sayi2: sayi2)
                    print("cikarma")
                case 3:
                    if  Int(sayi1) != 0{
                    presenterNesnesi?.bolmeYap(sayi1: sayi1, sayi2: sayi2)
                    print("bölme")
                    }else{
                        print("Pay kısmında 0 olamaz.")
                    }
                default:
                    print("Beklenmeyen SegmentIndex")
                }
            
            
        }
        
    }
 
   
}


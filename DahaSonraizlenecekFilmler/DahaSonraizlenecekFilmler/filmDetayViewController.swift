//
//  filmDetayViewController.swift
//  CoreDataEgzersiz
//
//  Created by Kadir Yasin Özmen on 21.07.2022.
//

import UIKit
import WebKit
import CoreData

class filmDetayViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet var filmAdiLAbel: UILabel!
    @IBOutlet var filmTuruLabel: UILabel!
    @IBOutlet var yonetmenLabel: UILabel!
    @IBOutlet var webView: WKWebView!
    
    
    @IBOutlet var silbuttonOutlet: UIButton!
    @IBOutlet var arsivdenCikarOutlet: UIButton!
    
    var film = Filmler()
    var arsiv = Arsiv()
    var gelisArsivMi = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if gelisArsivMi{
            if let filmAdı = arsiv.film_ad{
                filmAdiLAbel.text = filmAdı
            }
            if let filmTur = arsiv.film_tur{
                filmTuruLabel.text = filmTur
            }
            if let yonetmen = arsiv.yonetmen{
                yonetmenLabel.text = yonetmen
            }
//            if let url = URL(string: arsiv.link!){
//                webView.isHidden = false
//                self.webView.load(URLRequest(url: url))
//            }
            
            silbuttonOutlet.isHidden = false
            arsivdenCikarOutlet.isHidden = false
        }else{
            if let filmAdı = film.film_ad{
                filmAdiLAbel.text = filmAdı
            }
            if let filmTur = film.film_tur{
                filmTuruLabel.text = filmTur
            }
            if let yonetmen = film.yonetmen{
                yonetmenLabel.text = yonetmen
            }
            if let url = URL(string: film.link!){
                webView.isHidden = false
                self.webView.load(URLRequest(url: url))
            }
            silbuttonOutlet.isHidden = true
            arsivdenCikarOutlet.isHidden = true
        }
        
    }
    @IBAction func silbutton(_ sender: Any) {
        self.context.delete(arsiv)
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func arsivdenCikar(_ sender: Any) {
        let film = Filmler(context: context)
        
        film.film_tur = arsiv.film_tur
        film.link = arsiv.link
        film.yonetmen = arsiv.yonetmen
        film.film_ad = arsiv.film_ad
        
        self.context.delete(arsiv)
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    
}


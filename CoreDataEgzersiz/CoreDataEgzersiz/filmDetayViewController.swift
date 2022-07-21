//
//  filmDetayViewController.swift
//  CoreDataEgzersiz
//
//  Created by Kadir Yasin Özmen on 21.07.2022.
//

import UIKit
import WebKit

class filmDetayViewController: UIViewController {
    @IBOutlet var filmAdiLAbel: UILabel!
    @IBOutlet var filmTuruLabel: UILabel!
    @IBOutlet var yonetmenLabel: UILabel!
    @IBOutlet var webView: WKWebView!
    var film = Filmler()
    override func viewDidLoad() {
        super.viewDidLoad()

        if let filmAdı = film.film_ad{
            filmAdiLAbel.text = filmAdı
        }
        if let filmTur = film.film_tur{
            filmTuruLabel.text = filmTur
        }
        if let yonetmen = film.yonetmen{
            yonetmenLabel.text = yonetmen
        }
        if let webView = film.link{
            let url = URL(string: webView)!
            
            self.webView.load(URLRequest(url: url))
        }
    }
    


}

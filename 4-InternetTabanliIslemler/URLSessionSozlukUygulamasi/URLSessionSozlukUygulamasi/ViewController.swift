//
//  ViewController.swift
//  URLSessionSozlukUygulamasi
//
//  Created by Kadir Yasin Özmen on 5.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kelimeTableView: UITableView!
    
    var kelimeListesi = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kelimeTableView.delegate = self
        kelimeTableView.dataSource = self
        
        searchBar.delegate = self
        
        tumKelimelerAl()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let gidileceVC = segue.destination as! KelimeDetayViewController
        
        gidileceVC.kelime = kelimeListesi[indeks!]
    }
    
    func tumKelimelerAl(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")!
        
        URLSession.shared.dataTask(with: url) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do {
                let cevap = try JSONDecoder().decode(SozlukCevap.self, from: data!)
                if let gelenKelimelistesi = cevap.kelimeler {
                    
                    self.kelimeListesi = gelenKelimelistesi
                    
                }
                
                DispatchQueue.main.async {
                    self.kelimeTableView.reloadData()
                }
                
                
                
            }catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
        
    }
    
    
    func aramaYap(aramaKelimesi:String){
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/sozluk/kelime_ara.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "ingilizce=\(aramaKelimesi)"
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do {
                let cevap = try JSONDecoder().decode(SozlukCevap.self, from: data!)
                if let gelenKelimelistesi = cevap.kelimeler {
                    
                    self.kelimeListesi = gelenKelimelistesi
                    
                }
                
                DispatchQueue.main.async {
                    self.kelimeTableView.reloadData()
                }
                
                
                
            }catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
        
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kelime = kelimeListesi[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimeHucre", for: indexPath) as! KelimeHucreTableViewCell
        
        cell.ingilizceLabel.text = kelime.ingilizce
        cell.turkceLabel.text = kelime.turkce
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toKelimeDetay", sender: indexPath.row)
        
    }
    
    
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonucu : \(searchText)")
        
        aramaYap(aramaKelimesi: searchText)
    }
}

//
//  ViewController.swift
//  45.Uygulama-CoreDataKisilerUygulaması
//
//  Created by Kadir Yasin Özmen on 18.07.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class KisilerViewController: UIViewController{
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet var aramaBar: UISearchBar!
    @IBOutlet var kisilerTableView: UITableView!
    
    var kisilerListe = [Kisiler]()
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        aramaBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if aramaYapiliyorMu{
            aramaYap(kisi_ad: aramaKelimesi!)
        }else{
            tumKisilerAl()
        }
        kisilerTableView.reloadData()
    }
    func tumKisilerAl() {
        do {
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        } catch  {
            print("fetch failed")
        }
    }
    
    func aramaYap(kisi_ad:String){
        let fetchRequest: NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@", kisi_ad.lowercased())
        
        do {
            self.kisilerListe =  try context.fetch(fetchRequest)
        } catch  {
            print ("Cannot fetch Expenses")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toGuncelle"{
            let gidilecekVC = segue.destination as! KisiGuncelleViewController
            gidilecekVC.kisi = self.kisilerListe[indeks!]
        }
        if segue.identifier == "toDetay"{
            let gidilecekVC = segue.destination as! KisiDetayViewController
            gidilecekVC.kisi = self.kisilerListe[indeks!]
        }
    }
    
}

extension KisilerViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return kisilerListe.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre") as! KisilerTableViewCell
        var kisi = Kisiler()
        
        kisi = kisilerListe[indexPath.row]
        cell.HucreLabel.text = "\(kisi.kisi_ad!)--\(kisi.kisi_tel!)"
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { actin, vieww, boolValue in
            var kisi = Kisiler()
            
            kisi = self.kisilerListe[indexPath.row]
            
            self.context.delete(kisi)
            appDelegate.saveContext()
            if self.aramaYapiliyorMu{
                self.aramaYap(kisi_ad: self.aramaKelimesi!)
            }else{
                self.tumKisilerAl()
            }
            tableView.reloadData()
            print("\(self.kisilerListe[indexPath.row]) silindi")
        }
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") { actioon, vieww, boolValue in
            print("\(self.kisilerListe[indexPath.row]) güncellendi")
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
    }
    
    
}//tableView


extension KisilerViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        aramaKelimesi = searchText
        
        if searchText == ""{
            aramaYapiliyorMu = false
            self.tumKisilerAl()
        }else{
            aramaYapiliyorMu = true
            self.aramaYap(kisi_ad: searchText)
        }
        kisilerTableView.reloadData()
        
        
        print(searchText)
    }
}//searchBar


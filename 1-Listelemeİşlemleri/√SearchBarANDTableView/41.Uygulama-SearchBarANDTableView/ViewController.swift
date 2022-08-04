//
//  ViewController.swift
//  41.Uygulama-SearchBarANDTableView
//
//  Created by Kadir Yasin Özmen on 13.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var ulkeler = [String]()
    var aramaSonucuUlkeler = [String]()
    var aramaYapılıyormu = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ulkeler = ["amerika","türkiye","kanada","fransa","italya","paris","amsterdam","mısır","lübann","arabistan"]
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if aramaYapılıyormu {
            return aramaSonucuUlkeler.count
        }else{
            return ulkeler.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath)
        
        if aramaYapılıyormu{
            cell.textLabel?.text = aramaSonucuUlkeler[indexPath.row]
        }else{
            cell.textLabel?.text = ulkeler[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if aramaYapılıyormu{
            print(aramaSonucuUlkeler[indexPath.row])
        }else{
            print(ulkeler[indexPath.row])
        }
    }
    
    
}
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("arama sonucu:\(searchText)")
        
        if searchText == ""{
            aramaYapılıyormu = false
        }else{
            aramaYapılıyormu = true
            
            aramaSonucuUlkeler = ulkeler.filter({$0.lowercased().contains(searchText.lowercased())})
        }
        
        tableView.reloadData()
    }
}

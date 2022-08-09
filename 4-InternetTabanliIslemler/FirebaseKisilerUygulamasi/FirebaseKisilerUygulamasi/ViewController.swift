
import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    
    var kisilerListe = [Kisiler]()
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        searchBar.delegate = self
        
        ref = Database.database().reference()
        
        tumKisilerAl()
        print(kisilerListe)
        
    }
    
    func tumKisilerAl(){
        ref.child("kisiler").observe(.value) { snaption in
            if let gelenVeri = snaption.value as? [String:AnyObject]{
                self.kisilerListe.removeAll()
                for gelenSatirVerisi in gelenVeri{
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary{
                        
                        let key = gelenSatirVerisi.key
                        let kisi_ad = sozluk["kisi_ad"] as? String ?? ""
                        let kisi_tel = sozluk["kisi_tel"] as? String ?? ""
                        
                        let kisi = Kisiler(kisi_id: key, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                        self.kisilerListe.append(kisi)
                        
                    }
                }
            }else{
                self.kisilerListe = [Kisiler]()
            }
            DispatchQueue.main.async {
                self.kisilerTableView.reloadData()
            }
        }
    }
    func aramaYap(aramaKelimesi:String){
        ref.child("kisiler").observe(.value, with: {snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.kisilerListe.removeAll()
                for gelenSatirVerisi in gelenVeriButunu{
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary{
                        let key = gelenSatirVerisi.key
                        let kisi_ad = sozluk["kisi_ad"] as? String ?? ""
                        let kisi_tel = sozluk["kisi_tel"] as? String ?? ""
                        
                        if kisi_ad.contains(aramaKelimesi){
                            let kisi = Kisiler(kisi_id: key, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                            
                            self.kisilerListe.append(kisi)
                        }
                    }
                }
            }else{
                self.kisilerListe = [Kisiler]()
            }
            
            DispatchQueue.main.async {
                self.kisilerTableView.reloadData()
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toDetay"{
            let GVC = segue.destination as! KisiDetayViewController
            GVC.kisi = kisilerListe[sender as! Int]
        }
        if segue.identifier == "toGuncelle"{
            let GVC = segue.destination as! KisiGuncelleViewController
            GVC.kisi = kisilerListe[sender as! Int]
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
        
        cell.kisiYaziLabel.text = kisilerListe[indexPath.row].kisi_ad!
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {  (contextualAction, view, boolValue) in
            
             print("Sil tıklandı \(self.kisilerListe[indexPath.row])")
            let kisi = self.kisilerListe[indexPath.row]
            
            self.ref.child("kisiler").child(kisi.kisi_id!).removeValue()
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") {  (contextualAction, view, boolValue) in
            
             print("Güncelle tıklandı \(self.kisilerListe[indexPath.row])")
             
             self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }

        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
    }
    
    
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
          tumKisilerAl()
        }else{
          aramaYap(aramaKelimesi:searchText)
        }
    }
    
}

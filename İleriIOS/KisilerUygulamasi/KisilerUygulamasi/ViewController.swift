import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searcBar: UISearchBar!
    
    var kisiler = [Kisiler]()
    
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veritabaniKopyala()
        tableView.dataSource = self
        tableView.delegate = self
        
        searcBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if aramaYapiliyorMu{
            if let aramaKelimesi = aramaKelimesi {
                kisiler = KisilerDao().aramaYap(kisi_ad: aramaKelimesi)
                tableView.reloadData()
            }
            
        }else{
            kisiler = KisilerDao().tumKisileriAl()
            tableView.reloadData()
        }
        
        
    }
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var.Kopyalamaya gerek yok")
        }else{
            do {
                
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                
            }catch{
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toDetay"{
            let GVC = segue.destination as! detayViewController
            GVC.kisi = kisiler[indeks!]
        }
        if segue.identifier == "toGuncelle"{
            let GVC = segue.destination as! guncelleViewController
            GVC.kisi = kisiler[indeks!]
            
        }
    }
    
    func yenile(){
        kisiler = KisilerDao().tumKisileriAl()
        tableView.reloadData()
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisiler.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath)
        cell.textLabel?.text = "\(kisiler[indexPath.row].kisi_ad!)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if aramaYapiliyorMu{
            performSegue(withIdentifier: "toDetay", sender: indexPath.row)
            
        }else{
            tableView.reloadData()
            performSegue(withIdentifier: "toDetay", sender: indexPath.row)
        }
        
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let guncelle = UIContextualAction(style: .normal, title: "Güncelle") { action, view, bool in
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        let sil = UIContextualAction(style: .destructive, title: "Sil") { action, view, bool in
            
            KisilerDao().kisiSil(kisi_id: self.kisiler[indexPath.row].kisi_id!)
            self.yenile()
        }
        guncelle.backgroundColor = .brown
        
        
        return UISwipeActionsConfiguration(actions: [sil,guncelle])
    }
}
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        aramaKelimesi = searchText
        if searchText == ""{
            aramaYapiliyorMu = false
            yenile()
        }else{
            aramaYapiliyorMu = true
            print(searchText)
        }
        kisiler = KisilerDao().aramaYap(kisi_ad: searchText)
        tableView.reloadData()
        
        
    }
}

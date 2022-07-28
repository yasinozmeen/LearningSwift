import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let liste = KelimelerDao().tumKelimeleriAl()
    
    var aramaYapiliyorMu = false
    var arananListe = [Kelimeler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        veritabaniKopyala()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        let GVC = segue.destination as! detayViewController
        
        GVC.gelenKelime = sender as! Kelimeler
    }
    
    func veritabaniKopyala(){
        let bunleYolu = Bundle.main.path(forResource: "sozluk", ofType: ".sqlite")
        let hedefYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManeger = FileManager.default
        let kopyalanacakYer = URL(fileURLWithPath: hedefYolu).appendingPathComponent("sozluk.sqlite")
        
        if fileManeger.fileExists(atPath: kopyalanacakYer.path){
            print("veritabanı zaten var")
        }else{
            do{
                try fileManeger.copyItem(atPath: bunleYolu!, toPath: kopyalanacakYer.path)
                print("OKKKEY")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            aramaYapiliyorMu = false
            tableView.reloadData()
        }else{
            aramaYapiliyorMu = true
            
            print("Aranan kelime: \(searchText)")
            arananListe = KelimelerDao().aramaYapma(turkce: searchText)
            tableView.reloadData()
            
            for k in arananListe{
                print("Türkçe Gelen kelime : \(k.turkce!)")
            }
            print("Olması gereken Rows sayısı \(arananListe.count) ")
            print("----------------")
        }
        
    }// MARK: SearchBar
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sayi = 0
        if aramaYapiliyorMu{
            sayi = arananListe.count
        }else{
            sayi =  liste.count
        }
        
       return sayi
    } // MARK: NumberOfRows
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! hucreTableViewCell
        
        if aramaYapiliyorMu{
            cell.turkceLabel.text = arananListe[indexPath.row].turkce
            cell.inglizceLAbel.text = arananListe[indexPath.row].ingilizce
            
        }else{
            cell.inglizceLAbel.text = liste[indexPath.row].ingilizce
            cell.turkceLabel.text = liste[indexPath.row].turkce
            
        }
        return cell
    } // MARK: CellForRowAt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       
        
        
        if aramaYapiliyorMu{
            var gidecekKelime = arananListe[indexPath.row]
            performSegue(withIdentifier: "toDetay", sender: gidecekKelime)
        }else{
            var gidecekKelime = liste[indexPath.row]
            performSegue(withIdentifier: "toDetay", sender: gidecekKelime)
        }
    } // MARK: DidSelectRowAt
    
}


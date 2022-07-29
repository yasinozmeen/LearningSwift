import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var liste = Notlardao().tumNotlarAl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       veritabaniKopyala()
        
        for n in liste{
            print(n.ders_adi!)
            print("okkey")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        liste = Notlardao().tumNotlarAl()
        tableView.reloadData()
        
        var toplam = 0
        
        for n in liste {
            toplam = toplam + (n.not1! + n.not2!)/2
        }
        
        if liste.count != 0 {
            navigationItem.prompt  = "Ortalama : \(toplam / liste.count)"
        }else{
            navigationItem.prompt  = "Ortalama : YOK"
        }
        
        tableView.reloadData()
    }

    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "notlar", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
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
}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! hucreTableViewCell
        cell.dersAdiLabel.text = liste[indexPath.row].ders_adi
        cell.not1Label.text = "\(liste[indexPath.row].not1!)"
        cell.not2LAbel.text = "\(liste[indexPath.row].not2!)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetay", sender: indexPath)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            let GVC = segue.destination as! detayViewController
            GVC.indexpath = sender as? IndexPath
            
        }
    }
}

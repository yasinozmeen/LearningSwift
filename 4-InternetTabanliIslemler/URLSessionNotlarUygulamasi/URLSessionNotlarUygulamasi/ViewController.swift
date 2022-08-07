
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notTableView: UITableView!
    
    var notlarListe = [Notlar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notTableView.delegate = self
        notTableView.dataSource = self
        
        tumNotlarAl()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tumNotlarAl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNotDetay" {
            let indeks = sender as? Int
            
            let gidilecekVC = segue.destination as! NotDetayViewController
            
            gidilecekVC.not = notlarListe[indeks!]
            
        }
    }

    func tumNotlarAl(){
        let url = URL(string: "http://kasimadalan.pe.hu/notlar/tum_notlar.php")!
        
        URLSession.shared.dataTask(with: url) { data,response,error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            
            do{
                let cevap = try JSONDecoder().decode(NotlarCevap.self, from: data!)
                
                if let gelenNotListesi = cevap.notlar {
                    self.notlarListe = gelenNotListesi
                }else{
                    self.notlarListe = [Notlar]()
                }
                
                DispatchQueue.main.async {
                    
                    var toplam = 0
                    for n in self.notlarListe {

                        if let n1 = Int(n.not1!),let n2 = Int(n.not2!) {
                             toplam = toplam + (n1+n2)/2
                        }

                    }

                    if self.notlarListe.count != 0 {
                        self.navigationItem.prompt = "Ortalama : \(toplam / self.notlarListe.count)"
                    }else{
                        self.navigationItem.prompt = "Ortalama : YOK"
                    }

                    self.notTableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let not = notlarListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "notHucre", for: indexPath) as! NotHucreTableViewCell
        
        cell.labelDersAdi.text = not.ders_adi
        cell.labelNot1.text = String(not.not1!)
        cell.labelNot2.text = String(not.not2!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toNotDetay", sender: indexPath.row)
    }
}

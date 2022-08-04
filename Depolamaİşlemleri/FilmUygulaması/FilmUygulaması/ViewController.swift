import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var kategoriler = [Kategoriler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veritabaniKopyala()
        tableView.delegate = self
        tableView.dataSource = self
        kategoriler = KatagorilerDao().tumKategorilerAl()
    }
    
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "filmler", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("filmler.sqlite")
        
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
        let GVC = segue.destination as! katogorilerViewController
        
        let index = sender as! Int
        
        GVC.kategoriler = kategoriler[index]
        
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KatagorilerDao( ).tumKategorilerAl().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! kategoriTableViewCell
        cell.label.text = kategoriler[indexPath.row].katagori_ad
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toKategori", sender: indexPath.row)
        
    }
}

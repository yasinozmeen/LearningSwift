import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filmlerTableView: UITableView!
    var filmler = [Filmler]()
    var filmlerArsiv = [Arsiv]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmlerTableView.delegate = self
        filmlerTableView.dataSource = self
        searchBar.delegate = self
        tumFilmleriAl()
    }
    
    func tumFilmleriAl(){
        do {
            filmler = try context.fetch(Filmler.fetchRequest())
        }catch{
            print("fetch error")
        }
        
    }
    func degisikligiKaydetTabloYenile(){
        appDelegate.saveContext()
        self.tumFilmleriAl()
        filmlerTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tumFilmleriAl()
        filmlerTableView.reloadData()
    }
    
    
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmler.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmHucre") as! filmHucreTableViewCell
        
        cell.filmAdiLAbel.text = String(filmler[indexPath.row].film_ad ?? "hata")
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let film = self.filmler[indexPath.row]
        var arsivFilm = Arsiv(context: context)
        
        let sil = UIContextualAction(style: .destructive, title: "Sil") { acction, vieew, bool in
            print("\(film.film_ad ?? "" ) silindi")
            self.context.delete(self.filmler[indexPath.row])
            self.degisikligiKaydetTabloYenile()
           
        }
        
        let duzenle = UIContextualAction(style: .normal, title: "Düzenle") { acction, vieew, bool in
            
            let alertController = UIAlertController(title: "Düzenle", message: "Gerekli kısımları giriniz", preferredStyle: .alert)
            alertController.addTextField(){ textfield in
                textfield.placeholder = "Film Adı"
            }
            alertController.addTextField(){ textfield in
                textfield.placeholder = "Film Türü"
            }
            alertController.addTextField(){ textfield in
                textfield.placeholder = "Filmin Yönetmeni"
            }
            let kaydetButton = UIAlertAction(title: "Kaydet", style: .default) { action in
                
                self.filmler[indexPath.row].film_ad = alertController.textFields![0].text!
                self.filmler[indexPath.row].film_tur = alertController.textFields![1].text!
                self.filmler[indexPath.row].yonetmen = alertController.textFields![2].text!
                
                self.degisikligiKaydetTabloYenile()
            }
            alertController.addAction(kaydetButton)
            self.present(alertController, animated: true)
            
        }
        
        let arsivAction = UIContextualAction(style: .destructive, title: "Arşivle") { acction, vieew, bool in
            print("\(self.filmler[indexPath.row].film_ad ?? "" ) arşivlendi")
            self.context.delete(self.filmler[indexPath.row])
            arsivFilm.film_ad = film.film_ad
            arsivFilm.yonetmen = film.yonetmen
            arsivFilm.film_tur = film.yonetmen
            arsivFilm.link = film.link
            
            self.degisikligiKaydetTabloYenile()
           
        }
        return UISwipeActionsConfiguration(actions: [sil,duzenle,arsivAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetay", sender: filmler[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            let gidilecekVc = segue.destination as! filmDetayViewController
            gidilecekVc.film = sender as! Filmler
            gidilecekVc.gelisArsivMi = false
        }
        
    }
}
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

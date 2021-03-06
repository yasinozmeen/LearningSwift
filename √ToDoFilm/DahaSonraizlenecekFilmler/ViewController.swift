import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    
    @IBOutlet var filmlerTableView: UITableView!
    var filmler = [Filmler]()
    var filmlerArsiv = [Arsiv]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmlerTableView.delegate = self
        filmlerTableView.dataSource = self
    
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
    }//satır sayıısı
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmHucre") as! filmHucreTableViewCell
        
        cell.filmAdiLAbel.text = String(filmler[indexPath.row].film_ad ?? "hata")
        
        return cell
    }//hücre içeriği
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let film = self.filmler[indexPath.row]
    
        print("burası çalışıyo")
        
        let sil = UIContextualAction(style: .destructive, title: "Sil") { acction, vieew, bool in
            print("\(film.film_ad ?? "" ) silindi")
            self.context.delete(self.filmler[indexPath.row])
            self.degisikligiKaydetTabloYenile()
           
        }
        
        let duzenle = UIContextualAction(style: .normal , title: "Düzenle") { acction, vieew, bool in
            
             
            
            let alertController = UIAlertController(title: "Düzenle", message: "Gerekli kısımları giriniz", preferredStyle: .alert)
            alertController.addTextField(){ textfield in
                textfield.placeholder = "Film Adı"
                textfield.text = self.filmler[indexPath.row].film_ad

            }
            alertController.addTextField(){ textfield in
                textfield.placeholder = "Film Türü"
                textfield.text = self.filmler[indexPath.row].film_tur
            }
            alertController.addTextField(){ textfield in
                textfield.placeholder = "Filmin Yönetmeni"
                textfield.text = self.filmler[indexPath.row].yonetmen
            }
            let kaydetButton = UIAlertAction(title: "Kaydet", style: .default) { action in

                if alertController.textFields![0].text! != ""{
                    self.filmler[indexPath.row].film_ad = alertController.textFields![0].text!
                }
                if alertController.textFields![1].text! != ""{
                    self.filmler[indexPath.row].film_tur = alertController.textFields![1].text!
                }
                if alertController.textFields![2].text! != ""{
                    self.filmler[indexPath.row].yonetmen = alertController.textFields![2].text!
                }

                self.degisikligiKaydetTabloYenile()
            }
            
            let iptalButton = UIAlertAction(title: "İptal", style: .destructive) { action in
                alertController.textFields![0].text! = ""
                alertController.textFields![1].text! = ""
                alertController.textFields![2].text! = ""
            }
            
            alertController.addAction(kaydetButton)
            alertController.addAction(iptalButton)
            self.present(alertController, animated: true)
            
        }
        duzenle.backgroundColor = .blue
        let arsivAction = UIContextualAction(style: .normal, title: "Arşivle") { acction, vieew, bool in
            
            let arsivFilm = Arsiv(context: self.context)
            
            print("\(self.filmler[indexPath.row].film_ad ?? "" ) arşivlendi")
            self.context.delete(self.filmler[indexPath.row])
            arsivFilm.film_ad = film.film_ad
            arsivFilm.yonetmen = film.yonetmen
            arsivFilm.film_tur = film.film_tur
            arsivFilm.link = film.link
            
            self.degisikligiKaydetTabloYenile()
           
        }
        
        return UISwipeActionsConfiguration(actions: [sil,duzenle,arsivAction])
    }// kaydırmalı aksiyon
    
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


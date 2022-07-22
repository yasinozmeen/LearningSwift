import UIKit
import CoreData

class arsivViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let context = appDelegate.persistentContainer.viewContext
    
    var arsiv = [Arsiv]()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func tumFilmleriAl(){
        do {
            arsiv = try context.fetch(Arsiv.fetchRequest())
        }catch{
            print("fetch error")
        }
    }
    func degisikligiKaydetTabloYenile(){
        appDelegate.saveContext()
        self.tumFilmleriAl()
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tumFilmleriAl()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arsiv.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucre")
        cell?.textLabel?.text = arsiv[indexPath.row].film_ad
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "arsivToDetay", sender: arsiv[indexPath.row])
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "arsivToDetay"{
            let gidilecekVc = segue.destination as! filmDetayViewController
            gidilecekVc.arsiv = sender as! Arsiv
            gidilecekVc.gelisArsivMi = true
        }
        
    }
}

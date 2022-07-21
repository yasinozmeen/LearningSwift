import UIKit
import CoreData



class filmEkleViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    var rastgeleSayı = Int.random(in: 0...100)
    @IBOutlet var filmAdiTextField: UITextField!
    @IBOutlet var filmTuruTextField: UITextField!
    @IBOutlet var yonetmenTextField: UITextField!
    @IBOutlet var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmAdiTextField.text = "\(rastgeleSayı)"

    }
    @IBAction func ekleButton(_ sender: Any) {
        let film = Filmler(context: context)
        film.film_ad = filmAdiTextField.text
        film.film_tur = filmTuruTextField.text
        film.yonetmen = yonetmenTextField.text
        film.link = linkTextField.text
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    

}

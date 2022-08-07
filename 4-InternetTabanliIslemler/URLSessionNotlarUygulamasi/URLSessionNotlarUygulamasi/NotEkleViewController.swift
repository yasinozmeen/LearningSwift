import UIKit

class NotEkleViewController: UIViewController {
    @IBOutlet weak var textfieldDersAdi: UITextField!
    
    @IBOutlet weak var textfieldNot1: UITextField!
    @IBOutlet weak var textfieldNot2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func notEkle(_ sender: Any) {
         print("Ekle")
    }
}

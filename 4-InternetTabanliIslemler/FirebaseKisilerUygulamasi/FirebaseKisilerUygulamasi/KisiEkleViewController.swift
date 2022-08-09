
import UIKit
import Firebase

class KisiEkleViewController: UIViewController {

    @IBOutlet weak var kisiAdTextfield: UITextField!
    @IBOutlet weak var kisiTelTextfield: UITextField!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
       
    }
    
    @IBAction func ekle(_ sender: Any) {
        if let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text{
            kisiEkle(kisi_ad: ad, kisi_tel: tel)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func kisiEkle(kisi_ad:String,kisi_tel:String){
        let dict : [String:Any] = ["kisi_id":"","kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        
        let newRef = ref.child("kisiler").childByAutoId()
        
        newRef.setValue(dict)
    }

}

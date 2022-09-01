
import UIKit
import Firebase

class KisiGuncelleViewController: UIViewController {
    
    @IBOutlet weak var kisiAdTextfield: UITextField!
    @IBOutlet weak var kisiTelTextfield: UITextField!
    
    var kisi:Kisiler?
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        if let k = kisi{
            kisiAdTextfield.text = k.kisi_ad
            kisiTelTextfield.text = k.kisi_tel
        }
        
    }
    
    @IBAction func guncelle(_ sender: Any) {
        if let id = kisi?.kisi_id,  let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text{
            kisiGuncelle(kisi_id: id, kisi_ad: ad, kisi_tel: tel)
            navigationController?.popViewController(animated: true)
        }
    }
    func kisiGuncelle(kisi_id:String,kisi_ad:String,kisi_tel:String){
        
        ref.child("kisiler").child(kisi_id).updateChildValues(["kisi_ad":kisi_ad,"kisi_tel":kisi_tel])
        
    }
}

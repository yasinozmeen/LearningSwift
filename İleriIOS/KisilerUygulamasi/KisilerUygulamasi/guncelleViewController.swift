import UIKit

class guncelleViewController: UIViewController {
    
    var kisi:Kisiler?
    
    @IBOutlet var adLAbel: UITextField!
    @IBOutlet var telLAbel: UITextField!
    
    var kisiler = KisilerDao().tumKisileriAl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let kisi = kisi {
            
            adLAbel.text = kisi.kisi_ad!
            telLAbel.text = kisi.kisi_tel!
        }
    }
    @IBAction func guncelleButton(_ sender: Any) {
        if let ad = adLAbel.text, let tel = telLAbel.text, let kisi = kisi{
            
            KisilerDao().kisiGuncelle(kisi_id: kisi.kisi_id!, kisi_ad: ad, kisi_tel: tel)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

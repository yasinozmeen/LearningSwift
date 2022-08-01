import UIKit

class ekleViewController: UIViewController {
    @IBOutlet var kisiAdTextField: UITextField!
    @IBOutlet var kisiTelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    @IBAction func ekleButton(_ sender: Any) {
        
        if let ad = kisiAdTextField.text, let tel = kisiTelTextField.text{
            KisilerDao().kisiEkle(kisi_ad: ad, kisi_tel: tel)
            navigationController?.popViewController(animated: true)
        }
    }
}

import UIKit

class ekleViewController: UIViewController {
    @IBOutlet var dersAdiTextField: UITextField!
    @IBOutlet var not1TextField: UITextField!
    @IBOutlet var not2TextField: UITextField!
    @IBOutlet var cokluEklemeSwitch: UISwitch!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func button(_ sender: Any) {
        if let tempD = dersAdiTextField.text, let temp1 = Int(not1TextField.text!), let temp2 = Int( not2TextField.text!){
            Notlardao().notEkle(ders_adi: tempD, not1: temp1, not2: temp2)
        }
        if !cokluEklemeSwitch.isOn {
            
            navigationController?.popViewController(animated: true)
        }else{
            dersAdiTextField.text = ""
            not2TextField.text = ""
            not1TextField.text = ""
        }
    }
    
}

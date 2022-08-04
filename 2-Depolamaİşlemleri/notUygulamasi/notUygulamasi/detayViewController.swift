import UIKit

class detayViewController: UIViewController {
    @IBOutlet var dersAdiTExtField: UITextField!
    @IBOutlet var not1TExtField: UITextField!
    @IBOutlet var not2TextField: UITextField!
    
    var indexpath:IndexPath?
    var liste = Notlardao().tumNotlarAl()
    var not = Notlar()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let temp = indexpath{
            not = liste[temp.row]
            dersAdiTExtField.text = not.ders_adi
            not1TExtField.text = "\(not.not1!)"
            not2TextField.text = "\(not.not2!)"
        }
    }
    @IBAction func guncelleButton(_ sender: Any) {
        
        Notlardao().notGuncelle(not_id: not.not_id!, ders_adi: dersAdiTExtField.text! , not1: Int(not1TExtField.text!) ?? 0, not2: Int(not2TextField.text!) ?? 0)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func silButton(_ sender: Any) {
        Notlardao().notSil(not_id: not.not_id!)
        navigationController?.popViewController(animated: true)
    }
    
}

import UIKit

class sonucEkraniViewController: UIViewController {
    @IBOutlet var sonucLabel: UILabel!
    @IBOutlet var istatistikLabel: UILabel!
    
    var dogruSayisi:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light // sadece beyaz tema
        navigationItem.hidesBackButton = true
        
        if let d = dogruSayisi{
            sonucLabel.text = "\(d) Doğru \(5-d) Yanlış"
            istatistikLabel.text = "\(d*100/5) Başarı"
            if d*100/5>50{
                istatistikLabel.textColor = UIColor.green
            }else{
                istatistikLabel.textColor = UIColor.red
            }
        }
    }
    @IBAction func tekrarButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

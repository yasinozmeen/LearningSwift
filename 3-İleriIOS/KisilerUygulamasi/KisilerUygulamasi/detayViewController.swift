import UIKit


class detayViewController: UIViewController {
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var telLAbel: UILabel!
    var kisiler = KisilerDao().tumKisileriAl()
    var kisi:Kisiler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            adLabel.text = kisi?.kisi_ad!
            telLAbel.text = kisi?.kisi_tel!
        

    }
    
}

import UIKit

extension Notification.Name{
    static let bilridimAdi = Notification.Name("benimYayin")
}

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(yap(notification:)), name: .bilridimAdi, object: nil)
    }

    
    @objc func yap(notification : NSNotification){
        let gelenMesaj = notification.userInfo!["mesaj"]
        let gelenKisi = notification.userInfo!["nesne"] as! Kisiler
        
        self.label.text = "\(gelenMesaj!)-------\(gelenKisi.kisiAd!)-\(gelenKisi.kisiYas!)"
    }

}


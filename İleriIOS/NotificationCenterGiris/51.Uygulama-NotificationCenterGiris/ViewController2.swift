import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    @IBAction func bildirimGonder(_ sender: Any) {
        
        let kisi = Kisiler(kisiAd: "ahmet", kisiYas: 23)
        
        NotificationCenter.default.post(name: .bilridimAdi, object: nil, userInfo: ["mesaj":"MerhabaSwift","nesne":kisi])
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

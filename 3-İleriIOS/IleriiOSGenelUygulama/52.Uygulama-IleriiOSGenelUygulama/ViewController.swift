import UIKit
import UserNotifications


extension UIViewController:UNUserNotificationCenterDelegate{
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner,.sound,.badge])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let app = UIApplication.shared
        
        if app.applicationState == .active{
            print("önplandayken tıklandı")
            app.applicationIconBadgeNumber = 0
            
        }
        if app.applicationState == .inactive{
            print("arkaplandayken tıklandı")
            app.applicationIconBadgeNumber = 0
        }
        
      
        
        completionHandler()
        
    }
}



class ViewController: UIViewController {
    
    @IBOutlet var bildirimSuresiTextField: UITextField!
    @IBOutlet var bildirimIcerigiTextField: UITextField!
    @IBOutlet var bildirimSuresiLabel: UILabel!
    
    
    var bildirimIzin = false
    var sure = Int()
    var timer:Timer?
    var xasd = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { bool, error in
            self.bildirimIzin = bool
            let app = UIApplication.shared
            app.applicationIconBadgeNumber = 0
            if self.bildirimIzin{
                print("izin alındı")
            }else{
                print("izin alınamadı")
            }
            
        }
    }
    
    
    @IBAction func bildirimSuresiButton(_ sender: Any) {
        if let temp = Int(bildirimSuresiTextField.text!){
            sure = temp
            bildirimSuresiLabel.text = String(sure)
            bildirimSuresiLabel.isHidden = false
        }else{
            bildirimSuresiTextField.placeholder = "Lütfen sayı giriniz"
        }
    }
    
    @IBAction func bildirimGonderButton(_ sender: Any) {
        if bildirimIzin{
         
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(geriSay), userInfo: nil, repeats: true)
            
            let bildirimIcerik = UNMutableNotificationContent()
            
            bildirimIcerik.sound = UNNotificationSound.default
            bildirimIcerik.badge = (xasd + 1) as NSNumber
            bildirimIcerik.title = "Buraya bildirim başlığı geliyor"
            bildirimIcerik.subtitle = "Buraya altbaşlık geliyor"
            
            if let icerik = bildirimIcerigiTextField.text{
                bildirimIcerik.body = icerik
            }
            
            let tetiklieme = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.sure), repeats: false)
            
            let bildirimIstegi = UNNotificationRequest(identifier: "bildirimIstegi", content: bildirimIcerik, trigger: tetiklieme)
            UNUserNotificationCenter.current().add(bildirimIstegi)
            
        }
    }
    @objc func geriSay(){
        self.bildirimSuresiLabel.text = String(sure)
        
        if sure == 0 {
            timer?.invalidate()
            self.bildirimSuresiLabel.text = "Ring"
        }
        sure -= 1
    }
    
}


import UIKit

class soruEkraniViewController: UIViewController {
    @IBOutlet var dogruSayisiLabel: UILabel!
    @IBOutlet var yanlısSayisiLAbel: UILabel!
    @IBOutlet var soruSayisiLAbel: UILabel!
    @IBOutlet var bayrakImageView: UIImageView!
    
    @IBOutlet var buttonA: UIButton!
    @IBOutlet var buttonB: UIButton!
    @IBOutlet var buttonC: UIButton!
    @IBOutlet var buttonD: UIButton!
    
    var sorular = [Bayraklar]()
    var yanlisCevaplar = [Bayraklar]()
    
    var dogruSoru = Bayraklar()
    
    var soruSayac = 0
    var dogruSayisi = 0
    var yanlısSayisi = 0
    
    var secenekler = [Bayraklar]()
    var seceneklerKAristirmaListesi = Set <Bayraklar>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light // sadece beyaz tema
        sorular = BayraklarDao().random5Bayrak()
        for s in sorular{
            print(s.bayrak_ad!)
        }
        soruYukle()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC = segue.destination as! sonucEkraniViewController
        gidilecekVC.dogruSayisi = dogruSayisi
    }
    func soruYukle(){
        soruSayisiLAbel.text = "\(soruSayac+1).Soru"
        dogruSayisiLabel.text = "Doğru : \(dogruSayisi)"
        yanlısSayisiLAbel.text = "Yanlış : \(yanlısSayisi)"
        
        dogruSoru = sorular[soruSayac]
        
        bayrakImageView.image = UIImage(named: dogruSoru.bayrak_resim!)
        
        yanlisCevaplar = BayraklarDao().random3YanlısBayrak(bayrak_id: dogruSoru.bayrak_id!)
        
        seceneklerKAristirmaListesi.removeAll()
        
        seceneklerKAristirmaListesi.insert(dogruSoru)
        seceneklerKAristirmaListesi.insert(yanlisCevaplar[0])
        seceneklerKAristirmaListesi.insert(yanlisCevaplar[1])
        seceneklerKAristirmaListesi.insert(yanlisCevaplar[2])
        
        secenekler.removeAll()
        
        for s in seceneklerKAristirmaListesi{
            secenekler.append(s)
        }
        
        buttonA.setTitle(secenekler[0].bayrak_ad!, for: .normal)
        buttonB.setTitle(secenekler[1].bayrak_ad!, for: .normal)
        buttonC.setTitle(secenekler[2].bayrak_ad!, for: .normal)
        buttonD.setTitle(secenekler[3].bayrak_ad!, for: .normal)
    }
    
    func dogruKontrol(button:UIButton){
        let buttonYazi = button.titleLabel?.text
        let dogruCevap = dogruSoru.bayrak_ad
        
        if dogruCevap == buttonYazi {
            dogruSayisi += 1
        }else{
            yanlısSayisi += 1
        }
        dogruSayisiLabel.text = "Doğru : \(dogruSayisi)"
        yanlısSayisiLAbel.text = "Yanlış : \(yanlısSayisi)"
    }
    
    func soruSayacKontrol(){
        soruSayac += 1
        
        if soruSayac != 5 {
            soruYukle()
        }else{
            performSegue(withIdentifier: "toSonuc", sender: nil)
        }
    }
    
    @IBAction func buttonA(_ sender: Any) {dogruKontrol(button: buttonA)
        soruSayacKontrol()
    }
    @IBAction func buttonB(_ sender: Any) {dogruKontrol(button: buttonB)
        soruSayacKontrol()
    }
    @IBAction func buttonC(_ sender: Any) {dogruKontrol(button: buttonC)
        soruSayacKontrol()
    }
    @IBAction func buttonD(_ sender: Any) {dogruKontrol(button: buttonD)
        soruSayacKontrol()
    }
    

}

import UIKit

class ViewController: UIViewController, tableViewCellProtocol {
    
    
    @IBOutlet var yemekTableView: UITableView!
    
    var yemeklerListesi = [Yemekler]()
    override func viewDidLoad() {
        super.viewDidLoad()
        yemekTableView.dataSource = self
        yemekTableView.delegate = self
        
        let y1 = Yemekler(yemekId: 1, yemekAdi: "Ayran", yemekResimAdi: "ayran", yemekFiyat: 3.0)
        let y2 = Yemekler(yemekId: 2, yemekAdi: "Baklava", yemekResimAdi: "baklava", yemekFiyat: 20.0)
        let y3 = Yemekler(yemekId: 3, yemekAdi: "Fanta", yemekResimAdi: "fanta", yemekFiyat: 5.0)
        let y4 = Yemekler(yemekId: 4, yemekAdi: "Izgara Somon", yemekResimAdi: "izgarasomon", yemekFiyat: 25.0)
        let y5 = Yemekler(yemekId: 5, yemekAdi: "Izgara Tavuk", yemekResimAdi: "izgaratavuk", yemekFiyat: 15.0)
        let y6 = Yemekler(yemekId: 6, yemekAdi: "Kadayıf", yemekResimAdi: "kadayif", yemekFiyat: 16.0)
        let y7 = Yemekler(yemekId: 7, yemekAdi: "Kahve", yemekResimAdi: "kahve", yemekFiyat: 6.0)
        let y8 = Yemekler(yemekId: 8, yemekAdi: "Köfte", yemekResimAdi: "kofte", yemekFiyat: 15.0)
        let y9 = Yemekler(yemekId: 9, yemekAdi: "Lazanya", yemekResimAdi: "lazanya", yemekFiyat: 21.0)
        let y10 = Yemekler(yemekId: 10, yemekAdi: "Makarna", yemekResimAdi: "makarna", yemekFiyat: 13.0)
        let y11 = Yemekler(yemekId: 11, yemekAdi: "Pizza", yemekResimAdi: "pizza", yemekFiyat: 18.0)
        let y12 = Yemekler(yemekId: 12, yemekAdi: "Su", yemekResimAdi: "su", yemekFiyat: 1.0)
        let y13 = Yemekler(yemekId: 13, yemekAdi: "Sütlaç", yemekResimAdi: "sutlac", yemekFiyat: 10.0)
        let y14 = Yemekler(yemekId: 14, yemekAdi: "Tiramisu", yemekResimAdi: "tiramisu", yemekFiyat: 16.0)
        //Verilerin Listeye Eklenmesi
        yemeklerListesi.append(y1)
        yemeklerListesi.append(y2)
        yemeklerListesi.append(y3)
        yemeklerListesi.append(y4)
        yemeklerListesi.append(y5)
        yemeklerListesi.append(y6)
        yemeklerListesi.append(y7)
        yemeklerListesi.append(y8)
        yemeklerListesi.append(y9)
        yemeklerListesi.append(y10)
        yemeklerListesi.append(y11)
        yemeklerListesi.append(y12)
        yemeklerListesi.append(y13)
        yemeklerListesi.append(y14)
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gelenYemek = yemeklerListesi[indexPath.row]
        let cell = yemekTableView.dequeueReusableCell(withIdentifier: "hucre", for: indexPath) as! yemekTableViewCell
        cell.yemekFiyatLabel.text = "\(gelenYemek.yemekFiyat!)₺"
        cell.yemekImage.image = UIImage(named:gelenYemek.yemekResimAdi!)
        cell.yemekIsimLabel.text = gelenYemek.yemekAdi
        
        cell.yemekProtocol = self
        cell.indexPath = indexPath
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(yemeklerListesi[indexPath.row].yemekAdi!) Tıklandı")
    }
    func siparisEtbuttonTıklandı(indexPath: IndexPath) {
        let tiklananYemek = yemeklerListesi[indexPath.row]
        print("\(tiklananYemek.yemekAdi!) sipariş edildi\nÜcret: \(tiklananYemek.yemekFiyat!)₺")
    }

    
}

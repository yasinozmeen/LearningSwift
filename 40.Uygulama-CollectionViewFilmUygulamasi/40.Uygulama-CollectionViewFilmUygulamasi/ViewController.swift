import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var filmlerCollectionViewController: UICollectionView!
    var filmlerListesi = [Filmler]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let f1 = Filmler(filmId: 1, filmBaslik: "Django", filmResimAdi: "django", filmFiyat: 15.99)
        let f2 = Filmler(filmId: 2, filmBaslik: "Inception", filmResimAdi: "inception", filmFiyat: 15.99)
        let f3 = Filmler(filmId: 3, filmBaslik: "Interstellar", filmResimAdi: "interstellar", filmFiyat: 15.99)
        let f4 = Filmler(filmId: 4, filmBaslik: "Anadoluda", filmResimAdi: "birzamanlaranadoluda", filmFiyat: 15.99)
        let f5 = Filmler(filmId: 5, filmBaslik: "The Hateful Eight", filmResimAdi: "thehatefuleight", filmFiyat: 15.99)
        let f6 = Filmler(filmId: 6, filmBaslik: "The Pianist", filmResimAdi: "thepianist", filmFiyat: 15.99)
        
        filmlerListesi.append(f1)
        filmlerListesi.append(f2)
        filmlerListesi.append(f3)
        filmlerListesi.append(f4)
        filmlerListesi.append(f5)
        filmlerListesi.append(f6)
        
        filmlerCollectionViewController.delegate = self
        filmlerCollectionViewController.dataSource = self
    }


}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,filmCollectionViewProtocol{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filmlerCollectionViewController.dequeueReusableCell(withReuseIdentifier: "hucre", for: indexPath) as! filmCollectionViewController
        cell.filmKapakImage.image = UIImage(named: filmlerListesi[indexPath.row].filmResimAdi!)
        cell.filmIsimLabel.text = filmlerListesi[indexPath.row].filmBaslik
        cell.filmFiyatLabel.text = "\(filmlerListesi[indexPath.row].filmFiyat!) ₺"
        
        let tasarım : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.filmlerCollectionViewController.frame.size.width
        tasarım.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let hucreGenislik = (genislik-30)/2
        tasarım.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.65)
        tasarım.minimumLineSpacing = 10
        tasarım.minimumInteritemSpacing = 10
        cell.layer.borderColor = UIColor.systemBrown.cgColor
        cell.layer.borderWidth = 1
        
        filmlerCollectionViewController.collectionViewLayout = tasarım
        
        cell.filmProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func sepeteEkleButonTıklandı(indexPath: IndexPath) {
        print("sipariş edildi")
    }

    
}

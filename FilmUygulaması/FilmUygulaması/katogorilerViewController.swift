import UIKit

class katogorilerViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var filmListesi = [Filmler]()
    var kategoriler:Kategoriler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    
        
        
        let tasarim = UICollectionViewFlowLayout()
        let genislik = self.collectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let hucreGenislik = (genislik-30)/2
        
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik*1.7)
        
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        
        collectionView.collectionViewLayout = tasarim
        
        if let k = kategoriler{
            filmListesi = FilmlerDao().filmlerAl(kategori_id: k.katagori_id!)

        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gelen = sender as? Filmler{
            let GVC = segue.destination as! filmDetayViewController
            GVC.film = gelen
        }
        
    }
    
}
extension katogorilerViewController:UICollectionViewDelegate,UICollectionViewDataSource,filmHucreCollectionViewCellProtocol{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmHucre", for: indexPath) as! filmHucreCollectionViewCell
        cell.filmAd.text = filmListesi[indexPath.row].film_ad!
        cell.imageView.image = UIImage(named: filmListesi[indexPath.row].film_resim!)
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetay", sender: filmListesi[indexPath.row])
    }
    func siparisEdildi(indexPath: IndexPath) {
        print("Sipariş Edildi : \(filmListesi[indexPath.row].film_ad!)")
    }
    
}

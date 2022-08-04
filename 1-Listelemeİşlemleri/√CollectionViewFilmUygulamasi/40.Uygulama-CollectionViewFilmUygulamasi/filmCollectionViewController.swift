import UIKit
protocol filmCollectionViewProtocol{
    func sepeteEkleButonTıklandı(indexPath:IndexPath)
}
class filmCollectionViewController: UICollectionViewCell {
    @IBOutlet var filmKapakImage: UIImageView!
    @IBOutlet var filmIsimLabel: UILabel!
    @IBOutlet var filmFiyatLabel: UILabel!
    
    var filmProtocol:filmCollectionViewProtocol?
    var indexPath:IndexPath?
    
    @IBAction func sepeteEkleButton(_ sender: Any) {
        filmProtocol?.sepeteEkleButonTıklandı(indexPath: indexPath!)
    }
    
}

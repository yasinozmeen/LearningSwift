import UIKit

class filmDetayViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filmAdLabel: UILabel!
    @IBOutlet var filmyılLAbel: UILabel!
    @IBOutlet var katagori: UILabel!
    @IBOutlet var yönetmen: UILabel!
    
    var film = Filmler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: film.film_resim!)
        filmAdLabel.text = film.film_ad!
        filmyılLAbel.text = String(film.film_yil!)
        katagori.text = film.katagori?.katagori_ad!
        yönetmen.text = film.yonetmen?.yonetmen_ad!
    
    }
    
}

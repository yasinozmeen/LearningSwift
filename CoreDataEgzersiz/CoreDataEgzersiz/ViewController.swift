import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filmlerTableView: UITableView!
    var filmler = ["batman","başlangıç","shrek","arabalar","liyligül","mercedes","korku seansı"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        filmlerTableView.delegate = self
        filmlerTableView.dataSource = self
    }
    
    
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmler.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmHucre") as! filmHucreTableViewCell
        
        cell.filmAdiLAbel.text = filmler[indexPath.row]
        return cell
    }
    
}

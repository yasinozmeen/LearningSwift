import Foundation

class FilmlerDao{
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("filmler.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func filmlerAl(kategori_id:Int) -> [Filmler] {
        var liste = [Filmler]()
        
        db?.open()
        
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kategoriler,yonetmenler,filmler WHERE filmler.kategori_id = kategoriler.kategori_id and filmler.yonetmen_id = yonetmenler.yonetmen_id and filmler.kategori_id = ?", values: [kategori_id])
            
            while rs.next() {
                let kategori = Kategoriler(katagori_id: Int(rs.string(forColumn: "kategori_id") ?? "")!, katagori_ad: rs.string(forColumn: "kategori_ad")!)
                
                let yonetmen = Yonetmenler(yonetmen_id: Int(rs.string(forColumn: "yonetmen_id") ?? "" )!, yonetmen_ad: rs.string(forColumn: "yonetmen_ad")!)
                 
                let film = Filmler(film_id: Int(rs.string(forColumn: "film_id") ?? "")!, film_ad: rs.string(forColumn: "film_ad")!, film_yil: Int(rs.string(forColumn: "film_yil") ?? "")!, film_resim: rs.string(forColumn: "film_resim")!, katagori: kategori,yonetmen: yonetmen)
                
                
                liste.append(film)
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        
        
        db?.close()
        
        return liste
        
    }
    
}

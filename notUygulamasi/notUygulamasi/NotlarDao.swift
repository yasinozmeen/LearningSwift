import Foundation

class Notlardao {
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("notlar.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func tumNotlarAl() -> [Notlar] {
        var liste = [Notlar]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM notlar", values: nil)
            
            while rs.next() {
                let not = Notlar(not_id: Int(rs.string(forColumn: "not_id") ?? "" )!, ders_adi: rs.string(forColumn: "ders_adi") ?? "", not1: Int(rs.string(forColumn: "not1") ?? "")!, not2: Int(rs.string(forColumn: "not2") ?? "")! )
                
                liste.append(not)
            }
            print("okuma başarılı")
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
        
    }
    
    func notEkle(ders_adi:String,not1:Int,not2:Int){
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("INSERT INTO notlar (ders_adi,not1,not2) VALUES (?,?,?)", values: [ders_adi,not1,not2])
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func notGuncelle(not_id:Int,ders_adi:String,not1:Int,not2:Int){
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("UPDATE notlar SET ders_adi = ? , not1 = ? ,not2 = ? WHERE not_id = ?", values: [ders_adi,not1,not2,not_id])
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    
    func notSil(not_id:Int){
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM notlar WHERE not_id = ?", values: [not_id])
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
}

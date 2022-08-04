import Foundation

class KisilerDao{
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func tumKisileriAl() -> [Kisiler]{
        var liste = [Kisiler]()
        db?.open()
        do{
            let rs =  try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while rs.next(){
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id") ?? "")!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_tel: rs.string(forColumn: "kisi_tel")!)
                liste.append(kisi)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return liste
    }
    
    func aramaYap(kisi_ad:String) -> [Kisiler]{
        var liste = [Kisiler]()
        db?.open()
        do{
            let rs = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like '%\(kisi_ad)%'", values: [kisi_ad])
            
            while rs.next(){
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id") ?? "")!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_tel: rs.string(forColumn: "kisi_tel")!)
                liste.append(kisi)
            }
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    func kisiEkle(kisi_ad:String,kisi_tel:String){
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)", values: [kisi_ad,kisi_tel])
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    func kisiGuncelle(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("UPDATE kisiler SET kisi_ad = ? ,kisi_tel = ? WHERE kisi_id = ?", values: [kisi_ad,kisi_tel,kisi_id])
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func kisiSil(kisi_id:Int){
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
}

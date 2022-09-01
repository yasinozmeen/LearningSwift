import Foundation

class KelimelerDao{
    let db:FMDatabase?
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("sozluk.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func tumKelimeleriAl() -> [Kelimeler]{
        db?.open()
        
        var liste = [Kelimeler]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM kelimeler", values: nil)
            
            while rs.next(){
                let kelime = Kelimeler(kelime_id: Int(rs.string(forColumn: "kelime_id") ?? "")!, turkce: rs.string(forColumn: "turkce")!, ingilizce: rs.string(forColumn: "ingilizce")!)
                liste.append(kelime)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return liste
    }
    
    func aramaYapma(kelime:String) -> [Kelimeler]{
        db?.open()
        var liste = [Kelimeler]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM kelimeler WHERE turkce like '%\(kelime)%' OR ingilizce like '%\(kelime)%' ", values: [kelime])
            
            while rs.next(){
                let kelime = Kelimeler(kelime_id: Int(rs.string(forColumn: "kelime_id") ?? "" )!, turkce: rs.string(forColumn: "turkce")!, ingilizce: rs.string(forColumn: "ingilizce")!)
                
                liste.append(kelime)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        return liste
    }
}







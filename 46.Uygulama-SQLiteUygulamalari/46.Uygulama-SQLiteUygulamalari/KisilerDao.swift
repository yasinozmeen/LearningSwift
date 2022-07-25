import Foundation

class KisilerDao{
    
    let db: FMDatabase?
    
    init(){
        
        let hedefYolu = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veriTabaniUrl = URL(fileURLWithPath: hedefYolu).appendingPathComponent("kisilergiris.db")
        
        db = FMDatabase(path: veriTabaniUrl.path)
    }
    
    func tumKisileriAl() -> [Kisiler] {
        
        var liste = [Kisiler]()
        
        db?.open()
        
        do{
            let rs = try db?.executeQuery("SELECT * FROM kisiler ", values: nil)
            
            while rs!.next() {
                let kisi = Kisiler(kisi_id: Int((rs?.string(forColumn: "kisi_id"))!)! , kisi_ad: rs?.string(forColumn: "kisi_ad") ?? "", kisi_yas: Int(rs?.string(forColumn: "kisi_yas") ?? "")!)
                // yukarıdaki hataları gideremiyorum internetten bakılacak!
                liste.append(kisi)
            }
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        
        return liste
    }
    
}

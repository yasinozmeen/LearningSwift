import Foundation

class Notlar {
    var not_id:Int?
    var ders_adi:String?
    var not1:Int?
    var not2:Int?
    
    init() {
        
    }
    
    init(not_id:Int,ders_adi:String,not1:Int,not2:Int) {
        self.not_id = not_id
        self.ders_adi = ders_adi
        self.not1 = not1
        self.not2 = not2
        
    }
}

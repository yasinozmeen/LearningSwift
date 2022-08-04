import Foundation

class Kategoriler{
    var katagori_id:Int?
    var katagori_ad:String?
    
    init() {
        
    }
    init(katagori_id:Int,katagori_ad:String) {
        self.katagori_id = katagori_id
        self.katagori_ad = katagori_ad
    }
}

import Foundation

class Bayraklar:Hashable,Equatable{
    
    
    var bayrak_id:Int?
    var bayrak_ad:String?
    var bayrak_resim:String?
    
    init() {
        
    }
    init(bayrak_id:Int,bayrak_ad:String,bayrak_resim:String){
        self.bayrak_ad = bayrak_ad
        self.bayrak_id = bayrak_id
        self.bayrak_resim = bayrak_resim
    }
    var hashValue: Int{
        get{
            bayrak_id.hashValue
        }
    }
    static func == (lhs: Bayraklar, rhs: Bayraklar) -> Bool {
        return lhs.bayrak_id == rhs.bayrak_id
    }
    
}

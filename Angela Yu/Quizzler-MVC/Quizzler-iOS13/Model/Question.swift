import Foundation

struct Question{
    let q:String
    let a:[String]
    let correctAnswer:String
    init(q:String, a:[String],correctAnswer:String){
        self.q = q
        self.a = a
        self.correctAnswer = correctAnswer
    }
    
}

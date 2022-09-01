//
//  Kelimeler.swift
//  SozlukUygulaması
//
//  Created by Kadir Yasin Özmen on 28.07.2022.
//

import Foundation

class Kelimeler{
    var kelime_id:Int?
    var turkce :String?
    var ingilizce:String?
    
    init() {
        
    }
    
    init(kelime_id:Int,turkce :String,ingilizce:String) {
        self.kelime_id = kelime_id
        self.ingilizce = ingilizce
        self.turkce = turkce
    }
}

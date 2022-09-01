//
//  Kelimeler.swift
//  URLSessionSozlukUygulamasi
//
//  Created by Kadir Yasin Özmen on 6.08.2022.
//

import Foundation

class Kelimeler:Codable {
    var kelime_id:String?
    var ingilizce:String?
    var turkce:String?
    
    init() {
        
    }
    
    init(kelime_id:String,ingilizce:String,turkce:String) {
        self.kelime_id = kelime_id
        self.ingilizce = ingilizce
        self.turkce = turkce
    }
}

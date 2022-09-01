//
//  interactor.swift
//  ViperEgzersiz
//
//  Created by Kadir Yasin Özmen on 10.08.2022.
//

import Foundation

class Interactor:PresenterToInteractorProtocol{
    
    
    
    var presenter:InteractorToPresenterProtocol?
    
    func topla(sayi1:String,sayi2:String){
        if let s1 = Int(sayi1), let s2 = Int(sayi2){
            let sonuc = s1 + s2
             presenter?.presenteraVeriGonder(sonuc: String(sonuc))
        }
    }
    func carp(sayi1:String,sayi2:String){
        if let s1 = Int(sayi1), let s2 = Int(sayi2){
            let sonuc = s1 * s2
             presenter?.presenteraVeriGonder(sonuc: String(sonuc))
        }
    }
    func cikar(sayi1: String, sayi2: String) {
        if let s1 = Int(sayi1), let s2 = Int(sayi2){
            let sonuc = s1 - s2
             presenter?.presenteraVeriGonder(sonuc: String(sonuc))
        }
    }
    
    func bol(sayi1: String, sayi2: String) {
        if let s1 = Int(sayi1), let s2 = Int(sayi2){
            let sonuc = s1 / s2
             presenter?.presenteraVeriGonder(sonuc: String(sonuc))
        }
    }
}

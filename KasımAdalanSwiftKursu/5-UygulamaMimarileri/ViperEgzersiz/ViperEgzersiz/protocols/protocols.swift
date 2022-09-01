//
//  protocols.swift
//  ViperEgzersiz
//
//  Created by Kadir Yasin Özmen on 10.08.2022.
//

import Foundation

protocol ViewToPresenterProtocol{
    
    var interactor:PresenterToInteractorProtocol? {get set}
    var view:PresenterToViewProtocol? {get set}
    
    func toplamaYap(sayi1:String,sayi2:String)
    func cikarmaYap(sayi1:String,sayi2:String)
    func carpmaYap(sayi1:String,sayi2:String)
    func bolmeYap(sayi1:String,sayi2:String)
}

protocol PresenterToInteractorProtocol{
    var presenter:InteractorToPresenterProtocol? {get set}
    
    func topla(sayi1:String,sayi2:String)
    func cikar(sayi1:String,sayi2:String)
    func carp(sayi1:String,sayi2:String)
    func bol(sayi1:String,sayi2:String)
}

protocol InteractorToPresenterProtocol{
    func presenteraVeriGonder(sonuc:String)
}

protocol PresenterToViewProtocol{
    func vieweVeriGonder(sonuc:String)
}
extension ViewController :  PresenterToViewProtocol{
    func vieweVeriGonder(sonuc: String) {
        sonucLAbel.text = sonuc
    }
    
}

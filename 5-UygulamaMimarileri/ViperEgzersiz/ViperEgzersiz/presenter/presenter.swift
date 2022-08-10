//
//  presenter.swift
//  ViperEgzersiz
//
//  Created by Kadir Yasin Özmen on 10.08.2022.
//

import Foundation

class Presenter: ViewToPresenterProtocol{
    
    
    
    
    var interactor:PresenterToInteractorProtocol?
    var view:PresenterToViewProtocol?
    
    func toplamaYap(sayi1:String,sayi2:String){
        interactor?.topla(sayi1: sayi1, sayi2: sayi2)
    }
    func carpmaYap(sayi1: String, sayi2: String) {
        interactor?.carp(sayi1: sayi1, sayi2: sayi2)
    }
    func cikarmaYap(sayi1: String, sayi2: String) {
        interactor?.cikar(sayi1: sayi1, sayi2: sayi2)
    }
    
    func bolmeYap(sayi1: String, sayi2: String) {
        interactor?.bol(sayi1: sayi1, sayi2: sayi2)
    }
}
extension Presenter : InteractorToPresenterProtocol{
    func presenteraVeriGonder(sonuc: String) {
        view?.vieweVeriGonder(sonuc: sonuc)
    }
    
    
}

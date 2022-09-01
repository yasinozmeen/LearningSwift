////
////  router.swift
////  ViperEgzersiz
////
////  Created by Kadir Yasin Özmen on 10.08.2022.
////
//
//import Foundation
//
//protocol PresenterToRouterProtocol{
//    static func createModule(ref : ViewController)
//}
//
//
//class router : PresenterToRouterProtocol{
//    static func createModule(ref: ViewController) {
//        let presenter = Presenter()
//        ref.presenterNesnesi = presenter
//        ref.presenterNesnesi?.interactor = Interactor()
//        ref.presenterNesnesi?.view = ref
//        
//        ref.presenterNesnesi?.interactor?.presenter = presenter
//        
//    }
//}
//

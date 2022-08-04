//
//  filmHucreCollectionViewCell.swift
//  FilmUygulaması
//
//  Created by Kadir Yasin Özmen on 31.07.2022.
//

import UIKit

protocol filmHucreCollectionViewCellProtocol{
    func siparisEdildi(indexPath:IndexPath)
}

class filmHucreCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filmAd: UILabel!
    @IBOutlet var fiyat: UILabel!
    
    var hucreProtocol : filmHucreCollectionViewCellProtocol?
    var indexPath:IndexPath?
    
    
    @IBAction func button(_ sender: Any) {
        hucreProtocol?.siparisEdildi(indexPath: indexPath!)
    }
    
}

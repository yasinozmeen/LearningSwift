//
//  yemekTableViewCell.swift
//  37.Uygulama-YemekSepetiUygulaması
//
//  Created by Kadir Yasin Özmen on 12.07.2022.
//

import UIKit
protocol tableViewCellProtocol{
    func siparisEtbuttonTıklandı(indexPath:IndexPath)
}
class yemekTableViewCell: UITableViewCell{
    
    
    @IBOutlet var yemekCell: UIView!
    @IBOutlet var yemekIsimLabel: UILabel!
    @IBOutlet var yemekFiyatLabel: UILabel!
    @IBOutlet var yemekImage: UIImageView!
    
    var yemekProtocol:tableViewCellProtocol?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func yemekSiprarisEtButton(_ sender: Any) {
        yemekProtocol?.siparisEtbuttonTıklandı(indexPath: indexPath!)
    }
    
    
}

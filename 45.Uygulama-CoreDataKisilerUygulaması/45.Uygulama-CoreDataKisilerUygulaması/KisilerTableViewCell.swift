//
//  kisilerTableViewCell.swift
//  45.Uygulama-CoreDataKisilerUygulaması
//
//  Created by Kadir Yasin Özmen on 18.07.2022.
//

import UIKit
class KisilerTableViewCell: UITableViewCell {
    
    

    @IBOutlet var HucreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

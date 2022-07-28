//
//  hucreTableViewCell.swift
//  SozlukUygulaması
//
//  Created by Kadir Yasin Özmen on 28.07.2022.
//

import UIKit

class hucreTableViewCell: UITableViewCell {
    @IBOutlet var inglizceLAbel: UILabel!
    @IBOutlet var turkceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

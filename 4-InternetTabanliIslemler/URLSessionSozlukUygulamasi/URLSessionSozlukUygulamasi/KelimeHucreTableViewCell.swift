//
//  KelimeHucreTableViewCell.swift
//  URLSessionSozlukUygulamasi
//
//  Created by Kadir Yasin Özmen on 6.08.2022.
//

import UIKit

class KelimeHucreTableViewCell: UITableViewCell {
    @IBOutlet weak var ingilizceLabel: UILabel!
    
    @IBOutlet weak var turkceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  filmHucreTableViewCell.swift
//  CoreDataEgzersiz
//
//  Created by Kadir Yasin Özmen on 21.07.2022.
//

import UIKit

class filmHucreTableViewCell: UITableViewCell {

    @IBOutlet var filmAdiLAbel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func gosterButton(_ sender: Any) {
    }
    
}

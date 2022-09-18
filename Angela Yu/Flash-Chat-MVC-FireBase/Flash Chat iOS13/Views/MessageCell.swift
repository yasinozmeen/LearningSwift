//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Kadir Yasin Özmen on 16.09.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var messageBuble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBuble.layer.cornerRadius = messageBuble.frame.height / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

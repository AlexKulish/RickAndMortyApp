//
//  CustomTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 21.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

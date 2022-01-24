//
//  CustomTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 21.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleAspectFit
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.backgroundColor = .white
        }
    }
    
    // MARK: - Public methods
    func configure(with character: Character?) {
        guard let character = character else {
            return
        }
        
        nameLabel.text = character.name
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: character.image) else { return }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
            }
        }
    }

}

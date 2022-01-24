//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 21.01.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.layer.frame.height / 2
        }
    }
    
    // MARK: - Public properties
    var character: Character?
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = character?.description
        title = character?.name
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.fetchImage(from: self.character?.image) else { return }
            
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
            }
        }
    }
}

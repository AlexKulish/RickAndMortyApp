//
//  EpisodeDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 24.01.2022.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var episodeDescriptionLabel: UILabel!
    
    // MARK: - Public properties
    var episode: Episode!
    
    // MARK: - Private properties
    private var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted { $0.id < $1.id }
            }
        }
    }
    
    // MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setCharacters()
        tableView.backgroundColor = .black
        episodeDescriptionLabel.text = episode.description
        title = episode.episode
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! CharacterDetailsViewController
        detailVC.character = sender as? Character
    }
    
    // MARK: - Private methods
    
    private func setCharacters() {
        for characterUrl in episode.characters {
            NetworkManager.shared.fetchCharacter(from: characterUrl) { character in
                self.characters.append(character)
            }
        }
    }

}

// MARK: - Table view data source

extension EpisodeDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let characterURL = episode?.characters[indexPath.row]
        NetworkManager.shared.fetchCharacter(from: characterURL) { character in
            cell.configure(with: character)
        }
        return cell
    }
}

// MARK: - Table view delegate

extension EpisodeDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: character)
    }
    
}

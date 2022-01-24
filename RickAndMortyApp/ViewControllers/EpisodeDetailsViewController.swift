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
    var episode: Episode?
    
    // MARK: - Private properties
    private var characters: [Character] = []
    
    // MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .black
        episodeDescriptionLabel.text = episode?.description
        title = episode?.episode
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    }
    
}

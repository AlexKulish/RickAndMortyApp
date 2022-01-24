//
//  EpisodesTableViewController.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 24.01.2022.
//

import UIKit

class EpisodesTableViewController: UITableViewController {
    
    // MARK: - Public properties
    var character: Character?
    var episodes: [Episode] = []
    
    // MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        
        setupNavigationBar()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character?.episode.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode", for: indexPath)

        var content = cell.defaultContentConfiguration()
        let episodeURL = character?.episode[indexPath.row]
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        NetworkManager.shared.fetchEpisode(from: episodeURL) { result in
            
            switch result {
            case .success(let episode):
                self.episodes.append(episode)
                content.text = episode.name
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    private func setupNavigationBar() {
        
        title = "Episodes"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
    }
}

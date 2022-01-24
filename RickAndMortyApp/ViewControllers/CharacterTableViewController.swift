//
//  CharacterTableViewController.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 21.01.2022.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
    //MARK: - Private properties
    private var rickAndMorty: RickAndMorty?
    private var characters: [Character] = []
    
    //MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        setupNavigationBar()
        fetchData(from: Link.rickAndMortyApi.rawValue)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let character = characters[indexPath.row]
        cell.configure(with: character)

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let characterDetailsVC = segue.destination as? CharacterDetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = characters[indexPath.row]
        
        characterDetailsVC.character = character
        
    }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: rickAndMorty?.info.next)
        : fetchData(from: rickAndMorty?.info.prev)
    }
    
    
    // MARK: - Private methods
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.characters = rickAndMorty.results
            self.tableView.reloadData()
        }
    }
    
    private func setupNavigationBar() {
        
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .black
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        }
    }
}

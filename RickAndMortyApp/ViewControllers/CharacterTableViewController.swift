//
//  CharacterTableViewController.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 21.01.2022.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    
//    private var rickAndMorty: RickAndMorty?
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        fetchData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let character = characters[indexPath.row]
        cell.configure(with: character)

        return cell
    }
    
    private func fetchData() {
        NetworkManager.shared.fetch(dataType: RickAndMorty.self, from: Link.rickAndMortyApi.rawValue) { result in
            
            switch result {
            case .success(let rickAndMorty):
//                self.rickAndMorty = rickAndMorty
                self.characters = rickAndMorty.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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

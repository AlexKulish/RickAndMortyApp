//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Alex Kulish on 21.01.2022.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidUrl
    case decodingError
}

enum Link: String {
    case rickAndMortyApi = "https://rickandmortyapi.com/api/character"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(dataType: T.Type,
                             from url: String,
                             completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchData(from url: String?, completion: @escaping(RickAndMorty) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(rickAndMorty)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchEpisode(from url: String?, with completion: @escaping(Result<Episode, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let dataEpisode = try JSONDecoder().decode(Episode.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataEpisode))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

class ImageManager {
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringUrl = url else { return nil }
        guard let urlImage = URL(string: stringUrl) else { return nil }
        return try? Data(contentsOf: urlImage)
    }
}

//
//  NetworkManager.swift
//  OpenLibraryTest
//
//  Created by West on 13.04.23.
//

import UIKit

//MARK: Builder

class NetworkManagerBuilder {
    static func build() -> NetworkManagerProtocol {
        return NetworkManager()
    }
}

//MARK: Protocols

protocol NetworkManagerProtocol {
    func getBooks(completion: @escaping (ListOfBooksResponse?, Error?) -> Void)
    func getImage(coverID: Int, completion: @escaping (UIImage?) -> Void)
}

//MARK: NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    func getBooks(completion: @escaping (ListOfBooksResponse?, Error?) -> Void) {
        let urlString = "https://openlibrary.org/search.json?q=*&limit=20"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let books = try JSONDecoder().decode(ListOfBooksResponse.self, from: data)
                completion(books, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getImage(coverID: Int, completion: @escaping (UIImage?) -> Void) {
        let urlString = "https://covers.openlibrary.org/b/id/\(coverID)-L.jpg"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}

//
//  APIClient.swift
//  FamousSaying
//
//  Created by peo on 2022/07/22.
//

import Foundation

class APIClient {
    private let baseURL = "https://animechan.vercel.app/api/"
    
    static let shared = APIClient()
    
    private init() { }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidData
        case invalidParse
    }
    
    typealias NetworkCompletion = (Result<[QuoteModel], NetworkError>) -> Void

    func requestQuotes(completion: @escaping NetworkCompletion) {
        let path = "quotes"

        guard let url = URL(string: "\(baseURL)\(path)") else { return }

        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.invalidURL))
                return
            }
            
            guard let resultData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            if let quotes = self.parseData(resultData) as [QuoteModel]? {
                completion(.success(quotes))
            } else {
                completion(.failure(.invalidParse))
            }
        })
        
        task.resume()
    }
    
    func requestQuotes(animeTitle: String, completion: @escaping NetworkCompletion) {
        let path = "quotes/anime?title=\(animeTitle)"

        guard let url = URL(string: "\(baseURL)\(path)") else { return }

        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.invalidURL))
                return
            }
            
            guard let resultData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            if let quotes = self.parseData(resultData) as [QuoteModel]? {
                completion(.success(quotes))
            } else {
                completion(.failure(.invalidParse))
            }
        })
        
        task.resume()
    }
    
    func requestQuotes(characterName: String, completion: @escaping NetworkCompletion) {
        let path = "quotes/anime?title=\(characterName)"

        guard let url = URL(string: "\(baseURL)\(path)") else { return }

        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.invalidURL))
                return
            }
            
            guard let resultData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            if let quotes = self.parseData(resultData) as [QuoteModel]? {
                completion(.success(quotes))
            } else {
                completion(.failure(.invalidParse))
            }
        })
        
        task.resume()
    }
    
    func requestAllAvailableAnime(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        let path = "available/anime"

        guard let url = URL(string: "\(baseURL)\(path)") else { return }

        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.invalidURL))
                return
            }
            
            guard let resultData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            if let quotes = self.parseData(resultData) as [String]? {
                completion(.success(quotes))
            } else {
                completion(.failure(.invalidParse))
            }
        })
        
        task.resume()
    }
    
    func parseData<T: Codable>(_ quoteData: Data) -> [T]? {
        do {
            return try JSONDecoder().decode([T].self, from: quoteData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

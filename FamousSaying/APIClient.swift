//
//  APIClient.swift
//  FamousSaying
//
//  Created by peo on 2022/07/22.
//

import Foundation

final class APIClient {
    private let baseURL = "https://animechan.vercel.app/api/"
    
    static let shared = APIClient()
    
    private init() { }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidData
        case invalidParse
    }
    
    typealias NetworkCompletion<T: Codable> = (Result<[T], NetworkError>) -> Void

    func requestQuotes(completion: @escaping NetworkCompletion<QuoteModel>) {
        let path = "quotes"
        requestData(withURLString: path, completion: completion)
    }
    
    func requestQuotes(animeTitle: String, completion: @escaping NetworkCompletion<QuoteModel>) {
        let path = "quotes/anime?title=\(animeTitle)"
        requestData(withURLString: path, completion: completion)
    }
    
    func requestQuotes(characterName: String, completion: @escaping NetworkCompletion<QuoteModel>) {
        let path = "quotes/anime?title=\(characterName)"
        requestData(withURLString: path, completion: completion)
    }
    
    func requestAllAvailableAnime(completion: @escaping NetworkCompletion<String>) {
        let path = "available/anime"
        requestData(withURLString: path, completion: completion)
    }
    
    func requestData<T: Codable>(withURLString: String, completion: @escaping NetworkCompletion<T>) {
        guard let url = URL(string: "\(baseURL)\(withURLString)") else { return }
        
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
            
            if let quotes = self.parseData(resultData) as [T]? {
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

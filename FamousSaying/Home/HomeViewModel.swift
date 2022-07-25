//
//  HomeViewModel.swift
//  FamousSaying
//
//  Created by peo on 2022/07/25.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var quotes: [QuoteModel] = []
    @Published var currentQuote: QuoteModel?
    var index = 0
    
    // MARK: - Methods
    
    init() {
        APIClient.shared.requestQuotes { result in
            switch result {
            case .success(let quotes):
                self.quotes = quotes
                self.currentQuote = quotes[0]
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func isFavorited(_ quote: QuoteModel) -> Bool {
        for quote in Persistence.shared.fetchQuotes() {
            if quote.quote == currentQuote!.quote {
                return true
            }
        }
        return false
    }
    
    @objc func addToFavorite(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(systemName: "star") {
            let newQuote = Quote(context: Persistence.shared.context)
            newQuote.quote = currentQuote!.quote
            newQuote.anime = currentQuote!.anime
            newQuote.character = currentQuote!.character
            Persistence.shared.saveContext()
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            sender.tintColor = .systemYellow
        } else {
            for quote in Persistence.shared.fetchQuotes() {
                if quote.quote == currentQuote!.quote {
                    Persistence.shared.deleteQuote(quote)
                    sender.setImage(UIImage(systemName: "star"), for: .normal)
                    sender.tintColor = .gray
                    return
                }
            }
        }
    }
    
    func refreshQuotes() {
        APIClient.shared.requestQuotes { result in
            switch result {
            case .success(let quotes):
                self.quotes = quotes
                self.currentQuote = quotes[0]
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func forwardCurrentQuote() {
        if index == quotes.count - 1 {
            index = 0
            refreshQuotes()
        } else {
            index += 1
            currentQuote = quotes[index]
        }
    }
    
    @objc func backwardCurrentQuote() {
        if index > 0 {
            index -= 1
            currentQuote = quotes[index]
        }
    }
}

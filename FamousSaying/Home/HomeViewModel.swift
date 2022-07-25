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
    
    enum Favorite {
        case yes
        case no
    }
    
    var favoriteTrigger = PassthroughSubject<Favorite, Never>()
    
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
        for quote in CoreDataStack.shared.fetchQuotes() {
            if quote.quote == currentQuote!.quote {
                return true
            }
        }
        return false
    }
    
    func setFavoriteButton(by quote: QuoteModel) {
        if isFavorited(quote) {
            favoriteTrigger.send(.yes)
        } else {
            favoriteTrigger.send(.no)
        }
    }
    
    func addToFavorite() {
        let newQuote = Quote(context: CoreDataStack.shared.context)
        newQuote.quote = currentQuote!.quote
        newQuote.anime = currentQuote!.anime
        newQuote.character = currentQuote!.character
        CoreDataStack.shared.saveContext()
        favoriteTrigger.send(.yes)
    }
    
    func deleteFromFavorite() {
        for quote in CoreDataStack.shared.fetchQuotes() {
            if quote.quote == currentQuote!.quote {
                CoreDataStack.shared.deleteQuote(quote)
                favoriteTrigger.send(.no)
                return
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

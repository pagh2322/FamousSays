//
//  ViewModel.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//

import CoreData
import Combine

final class FavoriteViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var quotes: [Quote] = []
    
    // MARK: - Methods
    
    init() {
        quotes = Persistence.shared.fetchQuotes().reversed()
    }
    
    func deleteQuote(_ quote: Quote) {
        for index in quotes.indices {
            if quotes[index].quote == quote.quote {
                quotes.remove(at: index)
                Persistence.shared.deleteQuote(quote)
                return
            }
        }
    }
}

//
//  CoreDataStack.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    private init() { }
    
    lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError()
            }
        }
        return container
    }()
    
    func fetchQuotes() -> [Quote] {
        do {
            let request = Quote.fetchRequest()
            return try context.fetch(request)
        } catch {
            fatalError("fetch error: \(error)")
        }
    }
    
    func deleteQuote(_ quote: Quote) {
        let quotes = fetchQuotes()
        let deleteQuote = quotes.filter { $0.quote == quote.quote }[0]
        context.delete(deleteQuote)
        saveContext()
    }
    
    func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}

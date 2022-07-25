//
//  Quote+CoreDataProperties.swift
//  FamousSaying
//
//  Created by peo on 2022/07/23.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var anime: String?
    @NSManaged public var character: String?
    @NSManaged public var quote: String?

}

extension Quote : Identifiable {

}

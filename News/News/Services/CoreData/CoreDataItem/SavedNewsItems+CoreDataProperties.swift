//
//  SavedNewsItems+CoreDataProperties.swift
//  News
//
//  Created by Mahmud CIKRIK on 26.02.2024.
//
//

import Foundation
import CoreData


extension SavedNewsItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedNewsItems> {
        return NSFetchRequest<SavedNewsItems>(entityName: "SavedNewsItems")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var formattedDate: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imgUrl: String?
    @NSManaged public var newsUrl: String?
    @NSManaged public var pageTitle: String?
    @NSManaged public var savedAt: Date?
    @NSManaged public var title: String?

}

extension SavedNewsItems : Identifiable {

}

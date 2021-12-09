//
//  Substance+CoreDataProperties.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/8/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData


extension Substance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Substance> {
        return NSFetchRequest<Substance>(entityName: "Substance")
    }

    @NSManaged public var name: String?
    @NSManaged public var entries: NSSet?

}

// MARK: Generated accessors for entries
extension Substance {

    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: Entry)

    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: Entry)

    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)

    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)

}

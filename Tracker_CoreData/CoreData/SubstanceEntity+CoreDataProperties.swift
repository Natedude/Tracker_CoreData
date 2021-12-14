//
//  SubstanceEntity+CoreDataProperties.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/9/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData


extension SubstanceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubstanceEntity> {
        return NSFetchRequest<SubstanceEntity>(entityName: "SubstanceEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var entries: Set<EntryEntity>?

}

// MARK: Generated accessors for entries
extension SubstanceEntity {

    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: EntryEntity)

    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: EntryEntity)

    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)

    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)

}

//
//  EntryEntity+CoreDataProperties.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData


extension EntryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntryEntity> {
        return NSFetchRequest<EntryEntity>(entityName: "EntryEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var time: Date?
    @NSManaged public var amount: Double
    @NSManaged public var substance: SubstanceEntity?

}

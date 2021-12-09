//
//  Entry+CoreDataProperties.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/8/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var id: Int64
    @NSManaged public var time: Date?
    @NSManaged public var substance: Substance?

}

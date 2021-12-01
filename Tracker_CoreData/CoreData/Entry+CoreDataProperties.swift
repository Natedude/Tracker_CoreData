//
//  Entry+CoreDataProperties.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 11/29/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var medName: String?
    @NSManaged public var time: Date?
    @NSManaged public var id: Int64
    @NSManaged public var med_Rel: Medication?

}

//
//  Medication+CoreDataProperties.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 11/24/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var medName: String?
    @NSManaged public var mgPerUnit: Int64
    @NSManaged public var unitName: String?
    @NSManaged public var entry_Rel: Entry?

}

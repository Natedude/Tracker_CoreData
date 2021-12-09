//
//  Entry+CoreDataClass.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/8/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EntryMO)
public class Entry: NSManagedObject {

}

@objc(SubstanceMO)
public class Substance: NSManagedObject {
	
}

//struct Entry: Decodable {
//	var medName: String
//	var time: Date
//	var substance: SubstanceMO
//
//	init?(entryMO: NSManagedObject) {
//		guard
//			let medName = entryMO.value(forKey: "medName") as? String,
//			let time = entryMO.value(forKey: "time") as? Date,
//			let substance = entryMO.value(forKey: "substance") as? SubstanceMO
//		else {
//			return nil
//		}
//		self.medName = medName
//		self.time = time
//		self.substance = substance
//	}
//}

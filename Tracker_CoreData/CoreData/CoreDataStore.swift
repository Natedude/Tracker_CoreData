//
//  CoreDataStore.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/8/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import CoreData
import CoreDataManager

protocol DataReadWrite {
	func save(entry: Entry)
	//	func update(entry: Entry) // how to do this?
	//	func getAllEntries() -> [Entry]
	func getEntriesForDay(day: Date) -> [Entry]
//	func getSubstancesList() -> [Substance]
}

class CoreDataStore: DataReadWrite {
	private let cdm = CoreDataManager.sharedInstance
//	func getSubstancesList() -> [Substance] {
//		return [Substance()]
//	}
	
	func save(entry: Entry) {
		//
	}
	
	func getEntriesForDay(day: Date) -> [Entry] {
		return [Entry()]
	}
}

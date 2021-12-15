//
//  EntryManager.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/14/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import CoreData
import CoreDataManager

class EntryManager {
	// singleton pattern taken from https://krakendev.io/blog/the-right-way-to-write-a-singleton
	static let sharedInstance = EntryManager()
	static let format = DateFormatter()
	private let cdm = CoreDataManager.sharedInstance
//	private let sm = SubstanceManager.sharedInstance
	private var entries:[Entry] = []
	
	private init(){
		self.fetchEntries()
		EntryManager.format.dateFormat = "h:mma"
	}
	
	// Create new row in Entry table
	func insertNewEntry(sm: SubstanceManager){
		/* triggered when nav + button pressed
		* segue to new vc or modal?
		* get data for newEntry from the view or modal
		* make Entry and save
		*/
		print("EntryManager/insertNewEntry:")
		let context = self.cdm.mainContext
		let entryManager = context.managerFor(EntryEntity.self)
		let lastEntryID = (entryManager.max("id") as? Int64) ?? 0
		let substance = sm.getSubstances()[0]
		let e = Entry(id: (lastEntryID + 1), time: Date(), s: substance)
		substance.managedObject.addToEntries(e.managedObject)

		print("Added entry with Substance: \(e.substance.name)")
		print(EntryEntity.toString(ee: e.managedObject))
		do {
			try context.saveIfChanged()
			print("insertNewEntry: SUCCESS")
		} catch {
			print("insertNewEntry() ERROR: \(error)")
		}
		print("------------------------------------END insertNewEntry\n")
		self.fetchEntries()
		//		self.printEntries()
	}
	
	func count() -> Int {
		return self.entries.count
	}
	
	// Sync db -> self.entries
	// also print for now so I can see what EntryEntity.ArrToEntryArr prints
	// and then what this prints
	func fetchEntries() {
		print("EntryManager/fetchEntries:")
		let ctx = self.cdm.mainContext
		let eeArr: [EntryEntity] = ctx.managerFor(EntryEntity.self).array as [EntryEntity]
		self.entries = EntryEntity.eeArr2eArr(eeArr: eeArr)
		self.printEntries()
		//		print("------------------------------------END fetchEntries\n")
	}
	
	func printEntries(){
		print("EntryManager/printEntries:")
		_ = self.entries.map({
			(e: Entry) -> (Entry) in
			print(EntryEntity.toString(ee: e.managedObject))
			return e
		})
//		print("------------------------------------END printEntries\n")
	}
	
	func deleteAllEntries(){
		let ctx = self.cdm.mainContext
		_ = ctx.managerFor(EntryEntity.self).delete()
		do{
			try ctx.saveIfChanged()
		} catch {
			print("EntryManager/deleteAllEntries: ctx.saveIfChanged() Error: \(error)")
		}
	}
	
	func getEntries() -> [Entry] {
		return self.entries
	}
	
	func get(idx: Int) -> Entry {
		return self.entries[idx]
	}
}

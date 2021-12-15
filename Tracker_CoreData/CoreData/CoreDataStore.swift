////
////  CoreDataStore.swift
////  Tracker_CoreData
////
////  Created by Nathan Hildum on 12/8/21.
////  Copyright © 2021 Nathan Hildum. All rights reserved.
////

import Foundation
import CoreData
import CoreDataManager

class CoreDataStore {
	
	public static let sharedInstance = CoreDataStore()
	let cdm = CoreDataManager.sharedInstance
	var entries:[Entry] = []
	
	init(){
		
	}
	
	
	// Sync db -> self.entries
	// also print for now so I can see what EntryEntity.ArrToEntryArr prints
	// and then what this prints
	func fetchEntries() {
//		print("TrackerVC/fetchEntries:")
		let ctx = self.cdm.mainContext
		let eeArr: [EntryEntity] = ctx.managerFor(EntryEntity.self).array as [EntryEntity]
		self.entries = EntryEntity.eeArr2eArr(eeArr: eeArr)
		
		//printing
		self.printEntries()
//		self.tableView.reloadData()
//		self.showOrHideTable()
//		print("------------------------------------END fetchEntries\n")
	}
	
	func printEntries(){
		print("TrackerVC/printEntries:")
		_ = self.entries.map({
			(e: Entry) -> (Entry) in
			print(EntryEntity.toString(ee: e.managedObject))
			return e
		})
		print("------------------------------------END printEntries\n")
	}

}

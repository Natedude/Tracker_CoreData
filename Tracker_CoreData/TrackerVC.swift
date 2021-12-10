//  ViewController.swift
//  Tracker_CoreData
//  Created by Nathan Hildum on 11/24/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
/*
* Inspired by:
* - Included CoreDataManager Cocoapod
* - Example app in the CoreDataManager repo
*   - https://github.com/taaviteska/CoreDataManager
*/

import UIKit
import CoreData
import CoreDataManager



class TrackerVC: UIViewController {
	private let cdm = CoreDataManager.sharedInstance
	private let cds = CoreDataStore()
	let textViewStart = "Entries:\n"
	let format = DateFormatter()
	
	@IBAction func addEntryEntity(_ sender: Any) {
		print("addEntryButtonPress")
		self.insertNewEntryNew(sender: self)
	}
	
	var entries: [Entry] = []
	var substances: [Substance] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		format.dateFormat = "h:mma"
//		self.refreshEntries()
//		self.deleteAllEntries()
		self.fetchEntries()
		// fetchSubstances
		self.printEntries()
	}
	
	func getCtx() -> NSManagedObjectContext{
			return CoreDataManager.sharedInstance.mainContext
	}
	
//	func refreshEntries(){
//		self.fetchEntries()
//		self.displayEntries()
//	}
	
	func deleteAllEntries(){
		_ = self.cdm.mainContext.managerFor(EntryEntity.self).delete()
	}
	
	// Sync db -> self.entries
	func fetchEntries() {
		let ctx = self.cdm.mainContext
		let entryEntities = ctx.managerFor(EntryEntity.self).array as [EntryEntity]
		self.entries = EntryEntity.ArrToEntryArr(entityArr: entryEntities)
		print(
			"fetchEntries: typeof entries = \(type(of: self.entries))"
		)
	}
	
	func fetchSubstances() {
		let ctx = self.cdm.mainContext
		let substanceEntities = ctx.managerFor(SubstanceEntity.self).array as [SubstanceEntity]
		self.substances = SubstanceEntity.ArrToSubstanceArr(entityArr: substanceEntities)
		print(
			"fetchSubstances: typeof substances = \(type(of: self.substances))"
		)
	}
	
//	func getLastId() -> Int{
//		let context = self.cdm.mainContext
//		let entryManager = context.managerFor(EntryEntity.self)
//		return (entryManager.max("id") as? Int) ?? 0
//	}
	
	// Create new row in Entry table
	@objc func insertNewEntryNew(sender: AnyObject){
		/* triggered when nav + button pressed
		* segue to new vc or modal?
		* get data for newEntry from the view or modal
		* make Entry and save
		*/
		let context = self.cdm.mainContext
		let entryManager = context.managerFor(EntryEntity.self)
		let lastEntryID = (entryManager.max("id") as? Int64) ?? 0
		// ^ THIS LINE gives error because calls max and that tries to agregate all the entries, but the NSEntityDescription is returning nil
//		let s = Substance(name: "Test")
		let e = Entry(id: (lastEntryID + 1), time: Date(), substance: Substance().managedObject)
//		e.time = Date()
		print("Created new Date: \(e.time)")
//		e.id = Int64(lastEntryID + 1)
//		context.insert(e)
		do {
			try context.saveIfChanged()
			print("insertNewEntry: SUCCESS")
		} catch {
			print("insertNewEntry() ERROR: \(error)")
		}
		self.fetchEntries()
		self.printEntries()
	}
	
	// log contents of self.entries
	func printEntries(){
		print("-------------------------------- printing self.entries: ...")
		for i in 0..<self.entries.count {
			let e = self.entries[i]
			print("\(i): \(e)")
			print("---- '\(e.time)'")
		}
	}


}


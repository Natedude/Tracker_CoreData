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
		print("TrackerVC/addEntryButtonPress:")
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
//		self.printEntries()
	}
	
	func getCtx() -> NSManagedObjectContext{
			return CoreDataManager.sharedInstance.mainContext
	}
	
//	func refreshEntries(){
//		self.fetchEntries()
//		self.displayEntries()
//	}
	
	func deleteAllEntries(){
		let ctx = self.cdm.mainContext
		_ = ctx.managerFor(EntryEntity.self).delete()
		do{
			try ctx.saveIfChanged()
		} catch {
			print("TrackerVC/deleteAllEntries: ctx.saveIfChanged() Error: \(error)")
		}
	}
	
	// Sync db -> self.entries
	// also print for now so I can see what EntryEntity.ArrToEntryArr prints
	// and then what this prints
	func fetchEntries() {
		let ctx = self.cdm.mainContext
		let entryEntities = ctx.managerFor(EntryEntity.self).array as [EntryEntity]
		print("TrackerVC/fetchEntries:")
//		EntryEntity.printArr(eeArr: entryEntities)
		self.entries = EntryEntity.ArrToEntryArr(entityArr: entryEntities) as [Entry]
		self.printEntries()
	}
	
//	func fetchSubstances() {
//		let ctx = self.cdm.mainContext
//		let substanceEntities = ctx.managerFor(SubstanceEntity.self).array as [SubstanceEntity]
//		self.substances = SubstanceEntity.ArrToSubstanceArr(entityArr: substanceEntities)
//		print(
//			"fetchSubstances: typeof substances = \(type(of: self.substances))"
//		)
//	}
	
	// Create new row in Entry table
	@objc func insertNewEntryNew(sender: AnyObject){
		/* triggered when nav + button pressed
		* segue to new vc or modal?
		* get data for newEntry from the view or modal
		* make Entry and save
		*/
		print("TrackerVC/insertNewEntryNew:")
		let context = self.cdm.mainContext
		let entryManager = context.managerFor(EntryEntity.self)
		let lastEntryID = (entryManager.max("id") as? Int64) ?? 0
		let e = Entry(id: (lastEntryID + 1), time: Date(), sE: Substance().managedObject)
//		e.time = Date()
//		print("Created new Date: \(e.time)")
		print(EntryEntity.toString(ee: e.managedObject))
	 /* printing id=1, correct time, but substance is NOT giving back
		Fake_Substance from Substance() constructor... maybe remove Substance?
	  */
//		e.id = Int64(lastEntryID + 1)
//		context.insert(e)
		do {
			try context.saveIfChanged()
			print("insertNewEntry: SUCCESS")
		} catch {
			print("insertNewEntry() ERROR: \(error)")
		}
		self.fetchEntries()
//		self.printEntries()
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
	
	// log contents of self.entries
//	func printEntries(){
//		print("-------------------------------- printing self.entries: ...")
////		for i in 0..<self.entries.count {
////			let e = self.entries[i]
////			print("\(i): \(e)")
////			print("---- '\(e.time)'")
////		}
//		_ = self.entries.map({
//			(e: Entry) -> (Entry) in
//			print(EntryEntity.toString(ee: <#T##EntryEntity#>))
//		})
//	}


}


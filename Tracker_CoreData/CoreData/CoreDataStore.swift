////
////  CoreDataStore.swift
////  Tracker_CoreData
////
////  Created by Nathan Hildum on 12/8/21.
////  Copyright © 2021 Nathan Hildum. All rights reserved.
////
//
//import Foundation
//import CoreData
//import CoreDataManager
//
////protocol DataReadWrite {
////	func save(entryEntity: EntryEntity)
//	//	func update(entry: Entry) // how to do this?
//	//	func getAllEntries() -> [Entry]
////	func getEntriesForDay(day: Date) -> [EntryEntity]
////	func getSubstancesList() -> [Substance]
////}
//
//class CoreDataStore {
//	private let cdm = CoreDataManager.sharedInstance
//	var substances: [Substance] = []
//	var entries:[Entry] = []
//
////	init(){
////		self.fetchEntries()
////		self.fetchSubstances()
////	}
//
//	func getEntries() -> [Entry]{
//		return self.entries
//	}
//
//	func getSubstances() -> [Substance]{
//		return self.substances
//	}
//
//	func deleteAllEntries(){
//		let ctx = self.cdm.mainContext
//		_ = ctx.managerFor(EntryEntity.self).delete()
//		do{
//			try ctx.saveIfChanged()
//		} catch {
//			print("TrackerVC/deleteAllEntries: ctx.saveIfChanged() Error: \(error)")
//		}
//	}
//
//	func deleteAllSubstances(){
//		let ctx = self.cdm.mainContext
//		_ = ctx.managerFor(SubstanceEntity.self).delete()
//		do{
//			try ctx.saveIfChanged()
//		} catch {
//			print("TrackerVC/deleteAllSubstances: ctx.saveIfChanged() Error: \(error)")
//		}
//	}
//
//	func deleteEverything(){
//		self.deleteAllEntries()
//		self.deleteAllSubstances()
//	}
//
//	// Sync db -> self.entries
//	// also print for now so I can see what EntryEntity.ArrToEntryArr prints
//	// and then what this prints
//	func fetchEntries() {
//		print("TrackerVC/fetchEntries:")
//		let ctx = self.cdm.mainContext
//		let eeArr: [EntryEntity] = ctx.managerFor(EntryEntity.self).array as [EntryEntity]
//		self.entries = EntryEntity.eeArr2eArr(eeArr: eeArr)
//
//		//printing
//		self.printEntries()
//		//		self.tableView.reloadData()
//		print("------------------------------------END fetchEntries\n")
//	}
//
////	func fetchSubstances() {
////		print("TrackerVC/fetchSubstances:")
////		let ctx = self.cdm.mainContext
////		let eeArr: [SubstanceEntity] = ctx.managerFor(SubstanceEntity.self).array as [SubstanceEntity]
////		self.entries = SubstanceEntity.eeArr2eArr(eeArr: eeArr)
////
////		//printing
////		self.printSubstances()
////		//		self.tableView.reloadData()
////		print("------------------------------------END fetchEntries\n")
////	}
//
//
//
//	// Create new row in Entry table
//	@objc func insertNewEntry(sender: AnyObject){
//		/* triggered when nav + button pressed
//		* segue to new vc or modal?
//		* get data for newEntry from the view or modal
//		* make Entry and save
//		*/
//		print("TrackerVC/insertNewEntry:")
//		let context = self.cdm.mainContext
//		let entryManager = context.managerFor(EntryEntity.self)
//		let lastEntryID = (entryManager.max("id") as? Int64) ?? 0
//		let e = Entry(id: (lastEntryID + 1), time: Date(), s: Substance().managedObject)
//		//		e.time = Date()
//		//		print("Created new Date: \(e.time)")
//		guard let sName = e.substance.name else {
//			print("insertNewEntry: ERROR e.substance.name is nil")
//			do {
//				try context.saveIfChanged()
//				print("insertNewEntry: SUCCESS")
//			} catch {
//				print("insertNewEntry() ERROR: \(error)")
//			}
//			print("------------------------------------END insertNewEntry\n")
//			self.fetchEntries()
//			return
//		}
//		print("Created new Substance: \(sName)")
//		print(EntryEntity.toString(ee: e.managedObject))
//		/* printing id=1, correct time, but substance is NOT giving back
//		Fake_Substance from Substance() constructor... maybe remove Substance?
//		*/
//		//		e.id = Int64(lastEntryID + 1)
//		//		context.insert(e)
//		do {
//			try context.saveIfChanged()
//			print("insertNewEntry: SUCCESS")
//		} catch {
//			print("insertNewEntry() ERROR: \(error)")
//		}
//		print("------------------------------------END insertNewEntry\n")
//		self.fetchEntries()
//		//		self.printEntries()
//	}
//
//	func printEntries(){
//		print("TrackerVC/printEntries:")
//		_ = self.entries.map({
//			(e: Entry) -> (Entry) in
//			print(EntryEntity.toString(ee: e.managedObject))
//			return e
//		})
//		print("------------------------------------END printEntries\n")
//	}
//}

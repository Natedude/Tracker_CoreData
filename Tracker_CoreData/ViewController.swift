//  ViewController.swift
//  Tracker_CoreData
//  Created by Nathan Hildum on 11/24/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
/*
* Inspired by:
//  CoreDataManager.swift - DemoArcade
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
* AND
//  CoreDataManager.swift
//  Created by Manish Rathi on 02/10/14.
//  Copyright (c) 2014 Manish Rathi. All rights reserved.
*/

import UIKit
import CoreData
import CoreDataManager

class ViewController: UIViewController {
	
//	var cdm: CoreDataManager
	private let cdm = CoreDataManager.sharedInstance

	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var addEntryButton: UIButton!
	let textViewStart = "Entries:\n"
//	var viewDidLoad = false
	let format = DateFormatter()
	
	@IBAction func addEntryButtonPress(_ sender: Any) {
		print("addEntryButtonPress")
		self.insertNewEntry(sender: self)
		self.refreshEntries()
	}
	
	var entries: [NSManagedObject] = []
	// person.value(forKeyPath: "name") as? String
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		format.dateFormat = "h:mma"
		
//		let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//		guard let appDelegate =
//			UIApplication.shared.delegate as? AppDelegate else {
//				return
//		}
//		let ctx: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
		
//		let cdm = CoreDataManager.sharedInstance
		
		// Main context for UIKit
//		let ctx = cdm.mainContext
		
		// Background context for making updates
//		let bgctx = cdm.backgroundContext
		
		// load entries and show
		self.refreshEntries()
//		self.deleteAllEntries()
	}
	
	func getCtx() -> NSManagedObjectContext{
			return CoreDataManager.sharedInstance.mainContext
	}
	
	func refreshEntries(){
		let ctx = self.cdm.mainContext
		self.entries = ctx.managerFor(Entry.self).array
		self.displayEntries()
	}
	
	func deleteAllEntries(){
		_ = self.cdm.mainContext.managerFor(Entry.self).delete()
	}
	
	// Sync db -> self.entries
	func fetchEntries(ctx: NSManagedObjectContext) {
		// - get entries into array
//		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entry")
//		do {
//			self.entries = try ctx.fetch(fetchRequest)
//			print("fetchEntries:")
//			self.printEntries()
//		} catch let error as NSError {
//			print("Could not fetch. \(error), \(error.userInfo)")
//		}
		self.entries = ctx.managerFor(Entry.self).array
	}
	

	// display from self.entries to textView UI
	func displayEntries(){
		var text = ""
//		textView.text = text
		if self.entries.count == 0 {
			text = "No entries"
			print("displayEntries: No entries")
		} else {
			for e in self.entries {
//				print(e)
				let _id = e.value(forKey: "id") as? Int64
				let _medName = e.value(forKeyPath: "medName") as? String
				let _time = e.value(forKey: "time") as? Date
				
//				let medName = _medName
//				let id = _id
//				let time = _time
			
				guard let medName = _medName else {
					print("displayEntries: ERROR: medName")
					return
				}
				guard let id = _id else {
					print("displayEntries: ERROR: id")
					return
				}
				var timeStr = "No Date"
				if _time  != nil {
					let time = _time!
					timeStr = format.string(from: time)
				}
				
//				let fTime = format.string(from: time)
//				print("displayEntries: medName: \(medName)")
				text.append("id:\(id) - \(timeStr) - \(medName) \n")
//				print("displayEntries: appended. text=\n\(text)")
			}
		}
		self.textView.text = self.textViewStart + text
	}
	
	@objc func insertNewEntry(sender: AnyObject){
		
		let context = self.cdm.mainContext
		
		let entryManager = context.managerFor(Entry.self)
		let lastEntryID = (entryManager.max("id") as? Int) ?? 0
		
		let newEntry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: context) as! Entry
		newEntry.medName = "test"
		newEntry.time = Date()
		print("Created new Date: \(newEntry.time!)")
		newEntry.id = Int64(lastEntryID + 1)
		
		do {
			try context.saveIfChanged()
			print("insertNewEntry: SUCCESS")
//			return true
		} catch {
			print("insertNewEntry() ERROR: \(error)")
//			return false
		}
	}
//	// Create new row in Entry table
//	func save(medName: String) {
//		print("save: called")
////		guard let appDelegate =
////			UIApplication.shared.delegate as? AppDelegate else {
////				return
////		}
//		let ctx = self.cdm.mainContext
//
//		let entity = NSEntityDescription.entity(forEntityName: "Entry",in: ctx)!
//		let newEntry = NSManagedObject(entity: entity, insertInto: ctx)
//		newEntry.setValue(medName, forKeyPath: "medName")
//		print("save: newEntry = \(newEntry)")
//		do {
//			try ctx.save()
//			self.entries.append(newEntry)
//			print("save: appended. entries:")
//			self.printEntries()
//		} catch let error as NSError {
//			print("Could not save. \(error), \(error.userInfo)")
//		}
//	}
	
	// log contents of self.entries
	func printEntries(){
		print("-------------------------------- printing self.entries: ...")
		for i in 0..<self.entries.count {
			let e = self.entries[i]
			print("\(i): \(e)")
			print("---- '\(e.value(forKey: "medName")!)'")
		}
	}


}


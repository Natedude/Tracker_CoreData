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

struct Entry: Codable {
	var medName: String
	//		var time: Date
	//		var med_Rel: Medication
}

class TrackerVC: UIViewController {

	
//	var cdm: CoreDataManager
	private let cdm = CoreDataManager.sharedInstance

//	@IBOutlet weak var textView: UITextView!
//	@IBOutlet weak var addEntryButton: UIButton!
	let textViewStart = "Entries:\n"
//	var viewDidLoad = false
	let format = DateFormatter()
	
//	@IBAction func addEntryButtonPress(_ sender: Any) {
//		print("addEntryButtonPress")
//		self.insertNewEntry(sender: self)
////		self.refreshEntries()
//	}
	
	var entries: [NSManagedObject] = []
	// person.value(forKeyPath: "name") as? String
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		format.dateFormat = "h:mma"
//		self.refreshEntries()
//		self.deleteAllEntries()
	}
	
	func getCtx() -> NSManagedObjectContext{
			return CoreDataManager.sharedInstance.mainContext
	}
	
//	func refreshEntries(){
//		self.fetchEntries()
//		self.displayEntries()
//	}
	
	func deleteAllEntries(){
		_ = self.cdm.mainContext.managerFor(EntryMO.self).delete()
	}
	
	// Sync db -> self.entries
	func fetchEntries() {
		let ctx = self.cdm.mainContext
		self.entries = ctx.managerFor(EntryMO.self).array
	}
	

	// display from self.entries to textView UI
//	func displayEntries(){
//		var text = ""
////		textView.text = text
//		if self.entries.count == 0 {
//			text = "No entries"
//			print("displayEntries: No entries")
//		} else {
//			for e in self.entries {
////				e = e as Entry
//				print(e)
//				let _id = e.value(forKey: "id") as? Int64
//				let _medName = e.value(forKeyPath: "medName") as? String
//				let _time = e.value(forKey: "time") as? Date
//
////				let medName = _medName
////				let id = _id
////				let time = _time
//
//				guard let medName = _medName else {
//					print("displayEntries: ERROR: medName")
//					return
//				}
//				guard let id = _id else {
//					print("displayEntries: ERROR: id")
//					return
//				}
//				var timeStr = "No Date"
//				if _time  != nil {
//					let time = _time!
//					timeStr = format.string(from: time)
//				}
//
////				let fTime = format.string(from: time)
////				print("displayEntries: medName: \(medName)")
//				text.append("id:\(id) - \(timeStr) - \(medName) \n")
////				print("displayEntries: appended. text=\n\(text)")
//			}
//		}
//		self.textView.text = self.textViewStart + text
//	}
	
	// Create new row in Entry table
	@objc func insertNewEntry(sender: AnyObject){
		
		let context = self.cdm.mainContext
		
		let entryMOManager = context.managerFor(EntryMO.self)
		let lastEntryID = (entryMOManager.max("id") as? Int) ?? 0
		
		let newEntry = NSEntityDescription.insertNewObject(forEntityName: "EntryMO", into: context) as! EntryMO
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


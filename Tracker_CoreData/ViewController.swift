//
//  ViewController.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 11/24/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var addEntryButton: UIButton!
	let textViewStart = "Entries:\n"
	
	@IBAction func addEntryButtonPress(_ sender: Any) {
		self.save(medName: "test")
		print("addEntryButtonPress")
	}
	
	var entries: [NSManagedObject] = []
	// person.value(forKeyPath: "name") as? String
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
//		let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
		guard let appDelegate =
			UIApplication.shared.delegate as? AppDelegate else {
				return
		}
		let ctx: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
		
		
		// load entries and show
		self.fetchEntries(ctx: ctx)
		
		// display
		self.displayEntries()
	}
	
	// Sync db -> self.entries
	func fetchEntries(ctx: NSManagedObjectContext) {
		// - get entries into array
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entry")
		do {
			self.entries = try ctx.fetch(fetchRequest)
			print("fetchEntries:")
			self.printEntries()
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
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
				let s = e.value(forKeyPath: "medName") as? String
				guard let medName = s else {
					print("displayEntries: Error")
					return
				}
				print("displayEntries: medName: \(medName)")
				text.append(medName + "\n")
				print("displayEntries: appended. text=\n\(text)")
			}
			self.textView.text = self.textViewStart + text
		}
		
	}
	
	// Create new row in Entry table
	func save(medName: String) {
		print("save: called")
		guard let appDelegate =
			UIApplication.shared.delegate as? AppDelegate else {
				return
		}
		let ctx = appDelegate.persistentContainer.viewContext
		
		let entity = NSEntityDescription.entity(forEntityName: "Entry",in: ctx)!
		let newEntry = NSManagedObject(entity: entity, insertInto: ctx)
		newEntry.setValue(medName, forKeyPath: "medName")
		print("save: newEntry = \(newEntry)")
		do {
			try ctx.save()
			self.entries.append(newEntry)
			print("save: appended. entries:")
			self.printEntries()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
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


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

class ViewController: UIViewController {
	let cdm: CoreDataManager = CoreDataManager.shared
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var addEntryButton: UIButton!
	let textViewStart = "Entries:\n"
	
	@IBAction func addEntryButtonPress(_ sender: Any) {
		self.createEntry(medName: "test")
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


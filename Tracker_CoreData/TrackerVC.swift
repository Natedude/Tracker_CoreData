 //  ViewController.swift
//  Tracker_CoreData
//  Created by Nathan Hildum on 11/24/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
/*
*** Parenthetical Citations look like '(Source)' in comment above code ***
* Sources:
* - Included CoreDataManager Cocoapod
* - Example app in the CoreDataManager repo
*   - https://github.com/taaviteska/CoreDataManager
* - Populating Table View with NSFetchedResultsController by Bart Jacobs on (CocoaCasts)
*   - https://cocoacasts.com/populate-a-table-view-with-nsfetchedresultscontroller-and-swift-3
* -- maybe don't use that or else too much proj will be adapted from there
*/

import UIKit
import CoreData
import CoreDataManager

class TrackerVC: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
	
	// MARK: - CoreDataManager
	private let cdm = CoreDataManager.sharedInstance
//	private let cds = CoreDataStore()
	
	// MARK: - Table View
//	private let persistentContainer = NSPersistentContainer(name: "Entries") //(CocoaCasts)
	@IBOutlet weak var tableView: UITableView!
	
	// (CocoaCasts)
//	fileprivate lazy var fetchedResultsController: NSFetchedResultsController<EntryEntity> = {
//		// Create Fetch Request
//		let fetchRequest: NSFetchRequest<EntryEntity> = EntryEntity.fetchRequest()
//
//		// Configure Fetch Request
//		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
//
//		// Create Fetched Results Controller
//		let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//		// Configure Fetched Results Controller
//		fetchedResultsController.delegate = self
//
//		return fetchedResultsController
//	}()
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.entries.count
	}
	
	//(CocoaCasts)
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: EntryTableViewCell.reuseIdentifier, for: indexPath) as? EntryTableViewCell else {
			fatalError("Unexpected Index Path")
		}
		
		let entry = self.entries[indexPath.row]
//		entry.printEntry()
//		print(entry)
		let timeStr = format.string(from: entry.time)
//		print(timeStr)
//		print(cell)
	 
		guard let timeLabel = cell.timeLabel, let substanceLabel = cell.substanceLabel else {
			print("tableView: ERROR label is nil")
			return cell
		}
		timeLabel.text = timeStr
		substanceLabel.text = entry.substance.name
		
		return cell
	}
	
	// MARK: - Nav Controller
	@IBAction func addEntryEntity(_ sender: Any) {
		print("TrackerVC/addEntryButtonPress:")
		self.insertNewEntry(sender: self)
	}
	
	// MARK: - Tracker
	let format = DateFormatter()
	var substances: [Substance] = []
	var entries:[Entry] = []
	
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
	
	
	
//	func getCtx() -> NSManagedObjectContext{
//			return CoreDataManager.sharedInstance.mainContext
//	}
	
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
		print("TrackerVC/fetchEntries:")
		let ctx = self.cdm.mainContext
		let eeArr: [EntryEntity] = ctx.managerFor(EntryEntity.self).array as [EntryEntity]
		self.entries = EntryEntity.eeArr2eArr(eeArr: eeArr)

		//printing
		self.printEntries()
		self.tableView.reloadData()
		print("------------------------------------END fetchEntries\n")
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
	@objc func insertNewEntry(sender: AnyObject){
		/* triggered when nav + button pressed
		* segue to new vc or modal?
		* get data for newEntry from the view or modal
		* make Entry and save
		*/
		print("TrackerVC/insertNewEntry:")
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
		print("------------------------------------END insertNewEntry\n")
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
	
	// taken partly from answer by (Frankie) https://stackoverflow.com/questions/15746745/handling-an-empty-uitableview-print-a-friendly-message
	func showOrHideTable(){
		if self.entries.count == 0 {
			self.tableView.setEmptyMessage("No Entries")
		} else {
			self.tableView.restore()
		}
	}

}

// (Frankie)
extension UITableView {
	func setEmptyMessage(_ message: String) {
		let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
		messageLabel.text = message
		messageLabel.textColor = .black
		messageLabel.numberOfLines = 0
		messageLabel.textAlignment = .center
		messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
		messageLabel.sizeToFit()
		
		self.backgroundView = messageLabel
		self.separatorStyle = .none
	}
	
	func restore() {
		self.backgroundView = nil
		self.separatorStyle = .singleLine
	}
}

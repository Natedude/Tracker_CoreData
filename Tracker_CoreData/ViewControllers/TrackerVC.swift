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

class TrackerVC: UIViewController, UITableViewDataSource {
	
		// MARK: - Tracker
	private let cdm = CoreDataManager.sharedInstance
	private let em = EntryManager.sharedInstance
	private let sm = SubstanceManager.sharedInstance
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.showOrHideTable()
//		_ = Test()
	}
	
	// taken partly from answer by (Frankie) https://stackoverflow.com/questions/15746745/handling-an-empty-uitableview-print-a-friendly-message
	func showOrHideTable(){
		if self.em.count() == 0 {
			self.tableView.setEmptyMessage("No Entries")
		} else {
			self.tableView.restore()
		}
	}
	
	// MARK: - Table View
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.em.count()
	}
	
	//(CocoaCasts)
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: EntryTableViewCell.reuseIdentifier, for: indexPath) as? EntryTableViewCell else {
			fatalError("Unexpected Index Path")
		}
		
		let entry = self.em.get(idx: indexPath.row)
		//		entry.printEntry()
		//		print(entry)
		let timeStr = EntryManager.timeDateFormatter.string(from: entry.time)
		//		print(timeStr)
		//		print(cell)
		
		guard let timeLabel = cell.timeLabel, let substanceLabel = cell.substanceLabel else {
			print("tableView: ERROR label is nil")
			return cell
		}
		timeLabel.text = timeStr
		print("tableView: entry.substance.name=\(entry.substance.name)")
		substanceLabel.text = entry.substance.name
		
		return cell
	}
	
	// MARK: - Nav Controller
	@IBAction func addEntryEntity(_ sender: Any) {
		print("TrackerVC/addEntryButtonPress:")
		self.em.insertNewEntry(sm: self.sm)
		self.tableView.reloadData()
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


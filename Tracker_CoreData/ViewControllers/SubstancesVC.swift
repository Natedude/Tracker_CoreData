//
//  SubstancesVC.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/14/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import UIKit
import CoreData
import CoreDataManager

/* TODO:
- finish this vc to display substances
- make add button bring up alert to type in substance name and have cancel or OK
- maybe clicking a substance brings up alert asking to delete Cancel or Delete
- then move onto add entry vc
*/
class SubstanceVC: UIViewController, UITableViewDataSource {
	let sm = SubstanceManager.sharedInstance
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		//		format.dateFormat = "h:mma"
		//		self.refreshEntries()
		//		self.deleteAllEntries()
		//		self.deleteAllSubstances()
		//		self.addTestSub()
		//		self.fetchEntries()
		//		self.fetchSubstances()
		self.showOrHideTable()
		//		self.printEntries()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.sm.count()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: SubstanceTableViewCell.reuseIdentifier, for: indexPath) as? SubstanceTableViewCell else {
			fatalError("Unexpected Index Path")
		}
		
		let s = self.sm.get(idx: indexPath.row)
		//		entry.printEntry()
		//		print(entry)
//		let timeStr = format.string(from: entry.time)
		//		print(timeStr)
		//		print(cell)
		
		guard let substanceLabel = cell.substanceLabel else {
			print("SubstanceVC/tableView: ERROR label is nil")
			return cell
		}
//		timeLabel.text = timeStr
//		print("tableView: entry.substance.name=\(entry.substance.name)")
		substanceLabel.text = s.name
		
		return cell
	}
	
	
	// MARK: - Tracker
	private let cdm = CoreDataManager.sharedInstance
	var substances: [Substance] = []
	@IBOutlet weak var tableView: UITableView!
	
	func showOrHideTable(){
		if self.sm.count() == 0 {
			self.tableView.setEmptyMessage("No Substances")
		} else {
			self.tableView.restore()
		}
	}
}

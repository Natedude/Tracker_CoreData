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
	// MARK: - Tracker
	private let cdm = CoreDataManager.sharedInstance
	private let sm = SubstanceManager.sharedInstance
	@IBOutlet weak var tableView: UITableView!
	
	
	
	@IBAction func addButtonPress(_ sender: Any) {
		// TextField alert taken from https://www.youtube.com/watch?v=xLWfJIYg2PM
		let alert = UIAlertController(
			title: "Add New Substance",
			message: "Type in the name of the new substance you want to add:",
			preferredStyle: .alert)
		
		alert.addTextField{field in
			field.placeholder = "Name"
			field.returnKeyType = .continue
			field.keyboardType = .default
		}
		
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
			guard let fields = alert.textFields else {
				return
			}
			let nameField = fields[0]
			guard let name = nameField.text, !name.isEmpty else {
				print("Invalid entry")
				return
			}
			self.sm.insertNewSub(name: name)
			self.tableView.reloadData()
		}))
		self.present(alert, animated: true)
//		print(alert.getStatus())
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		self.showOrHideTable()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.sm.count()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: SubstanceTableViewCell.reuseIdentifier, for: indexPath) as? SubstanceTableViewCell else {
			fatalError("Unexpected Index Path")
		}
		let s = self.sm.get(idx: indexPath.row)
		
		guard let substanceLabel = cell.substanceLabel else {
			print("SubstanceVC/tableView: ERROR label is nil")
			return cell
		}
		substanceLabel.text = s.name
		
		return cell
	}
	
	// taken partly from answer by (Frankie) https://stackoverflow.com/questions/15746745/handling-an-empty-uitableview-print-a-friendly-message
	func showOrHideTable(){
		if self.sm.count() == 0 {
			self.tableView.setEmptyMessage("No Substances")
		} else {
			self.tableView.restore()
		}
	}
}

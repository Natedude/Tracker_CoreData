//
//  AddEntryVC.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/14/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import UIKit
import AUPickerCell

/*
TODO:
- add amount to entries
- style
- see if I can do better alerts with toasts
*/

class AddEntryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, AUPickerCellDelegate {
	
	let sm = SubstanceManager.sharedInstance
	let em = EntryManager.sharedInstance
	var subArr: [String]!
	var subSelectedStr: String!
	var datePicked: Date!
	var amountEnteredSW = StringWrapper()
	var estimatedRowHeight: CGFloat = 44
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		print("addEntryVC/viewDidLoad")
		self.subArr = self.sm.subsAsStringArr()
		if self.subArr.count == 0 {
			self.subArr = ["No Substances"]
		}
		self.subSelectedStr = self.subArr[0]
		self.datePicked = Date()
		self.amountEnteredSW.wrappedString = "0.00"
		self.tableView.restore()
		self.tableView.reloadData()
		self.tableView.register(AmountTableViewCell.nib(), forCellReuseIdentifier: AmountTableViewCell.reuseIdentifier)
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		//trigger cell picker list reload TODO:
		//		self.tableView.reloadData()
		//		guard var cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AUPickerCell else {
		//			print("AddEntryVC/viewWillAppear: ")
		//			return
		//		}
		//		cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
		//		cell.delegate = self
		//		cell.values = self.sm.subsAsStringArr()
		//		var firstVal = "No Substances"
		//		if cell.values.count != 0 {
		//			firstVal = cell.values[0]
		//		}
		//		self.subSelectedStr = firstVal
		//		print("AddEntryVC/viewWillAppear: set cell.values = \(cell.values)")
		//		let cell = self.makeNewPickerDefaultCell()
		//		self.tableView.
		/* how do I set the cell in the array? in the tv
		- there is no array!
		*/
		print("addEntryVC/viewWillAppear")
		self.needNewPickerDefaultCell = true
		//		self.tableView.reloadData()
		
		//		// substance
		//		let cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
		//		cell.delegate = self
		//		//				cell.separatorInset = UIEdgeInsets.zero
		//		//				var separatorColor: UIColor?
		//		//				cell.leftLabel.constraint()
		//		cell.values = self.sm.subsAsStringArr()
		//		if cell.values.count == 0 {
		//			print("cell.values.count == 0")
		//			cell.values = ["No Substances"]
		//			cell.rightLabel.textColor = UIColor.red
		//		} else {
		//			print("cell.values.count != 0")
		//			cell.rightLabel.textColor = UIColor.darkText
		//		}
		//		cell.selectedRow = 0
		//		//				cell.sele
		//		// TODO: how to disable expanding? and then when I get
		//		//cell.setSelectedRow(0,false)
		//		cell.leftLabel.text = "Substance:"
		//		cell.leftLabel.textColor = UIColor.lightText
		//		cell.tintColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
		//		cell.backgroundColor = #colorLiteral(red: 0.6344745755, green: 0.5274511576, blue: 0.4317585826, alpha: 1)
		//		//				print("AddEntryVC/cellForRowAt(1): returing\n\(cell)")
		//		return cell
	}
	var needNewPickerDefaultCell = false
	
	func getPickerDefaultCell() -> AUPickerCell {
		
		if self.needNewPickerDefaultCell {
			self.needNewPickerDefaultCell = false
			print("AddEntryVC/getPickerDefaultCell: self.needNewPickerPickerDefault ")
			let cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
			cell.delegate = self
			cell.values = self.sm.subsAsStringArr()
			if cell.values.count == 0 {
				print("cell.values.count == 0")
				cell.values = ["No Substances"]
				cell.rightLabel.textColor = UIColor.red
			} else {
				print("cell.values.count != 0")
				cell.rightLabel.textColor = UIColor.darkText
			}
			cell.selectedRow = 0
			self.subSelectedStr = self.subArr[0]
			cell.leftLabel.text = "Substance:"
			cell.leftLabel.textColor = UIColor.lightText
			cell.tintColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
			cell.backgroundColor = #colorLiteral(red: 0.6344745755, green: 0.5274511576, blue: 0.4317585826, alpha: 1)
			print("AddEntryVC/getPickerDefaultCell: set cell.values = \(cell.values)")
			return cell
		} else {
			//			return AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
			let cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
			//			let cell = self.getPickerDefaultCell() //?
			cell.delegate = self
			//				cell.separatorInset = UIEdgeInsets.zero
			//				var separatorColor: UIColor?
			//				cell.leftLabel.constraint()
			cell.values = self.sm.subsAsStringArr()
			if cell.values.count == 0 {
				print("cell.values.count == 0")
				cell.values = ["No Substances"]
				cell.rightLabel.textColor = UIColor.red
			} else {
				print("cell.values.count != 0")
				cell.rightLabel.textColor = UIColor.darkText
			}
			cell.selectedRow = 0
			//				cell.sele
			// TODO: how to disable expanding? and then when I get
			//cell.setSelectedRow(0,false)
			cell.leftLabel.text = "Substance:"
			cell.leftLabel.textColor = UIColor.lightText
			cell.tintColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
			cell.backgroundColor = #colorLiteral(red: 0.6344745755, green: 0.5274511576, blue: 0.4317585826, alpha: 1)
			//				print("AddEntryVC/cellForRowAt(1): returing\n\(cell)")
			return cell
		}
	}
	
	func makeNewPickerDefaultCell() -> AUPickerCell {
		//		guard var cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AUPickerCell else {
		//			print("AddEntryVC/makeNewPickerDefaultCell:  cell is nil")
		//			return AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
		//		}
		print("AddEntryVC/makeNewPickerDefaultCell")
		let cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
		//		var cell = tableView.dequeueReusableCell(withIdentifier: AmountTableViewCell.reuseIdentifier, for: indexPath) as? AmountTableViewCell else {
		//			fatalError("Unexpected Index Path")
		//		}
		cell.delegate = self
		cell.values = self.sm.subsAsStringArr()
		if cell.values.count == 0 {
			print("cell.values.count == 0")
			cell.values = ["No Substances"]
			cell.rightLabel.textColor = UIColor.red
		} else {
			print("cell.values.count != 0")
			cell.rightLabel.textColor = UIColor.darkText
		}
		cell.selectedRow = 0
		self.subSelectedStr = self.subArr[0]
		cell.leftLabel.text = "Substance:"
		cell.leftLabel.textColor = UIColor.lightText
		cell.tintColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
		cell.backgroundColor = #colorLiteral(red: 0.6344745755, green: 0.5274511576, blue: 0.4317585826, alpha: 1)
		print("AddEntryVC/makeNewPickerDefaultCell: set cell.values = \(cell.values)")
		return cell
	}
	
	@IBAction func addButtonPress(_ sender: Any) {
		// test amount
		//		let formatter = NumberFormatter()
		//		formatter.numberStyle = .none
		print("AddEntryVC/addButtonPress:")
		
		let filteredString = self.amountEnteredSW.wrappedString.filter("0123456789.".contains)
		//remove commas
		//		string = string.filter("0123456789.".contains)
		print("filtered string = \(filteredString)")
		
		//		amountEnteredAsNumber = formatter.doub
		guard let amountDouble = Double(filteredString) else {
			print("AddEntryVC/addButtonPress: amountDouble entered == nil")
			return
		}
		print("amountDouble entered = \(amountDouble)")
		//		let date = EntryManager.timeDateFormatter.string(from: self.datePicked)
		//		print("AddEntryVC/addButtonPress: date = \(date)")
		//		print("AddEntryVC/addButtonPress: sub = \(self.subSelectedStr ?? "nil")")
		
		if self.subSelectedStr == "No Substances" {
			self.noSubstancesAlert(handler: { uia in
				self.performSegue(withIdentifier: "addSubstanceSegue", sender: self)
			})
		}
		
		if amountDouble > 0 {
			// add entry
			
			// get sub
			guard let sub = self.sm.getSubFromString(str: self.subSelectedStr) else {
				print("AddEntryVC/addButtonPress: subSelectedStr ERROR subStr = nil") ///////////////////// CHANGE
				return
			}
			print("AddEntryVC/addButtonPress: right before insert: filtered string = \(filteredString)")
			self.em.insertNewEntry(date: datePicked, sub: sub, amt: filteredString, sm: self.sm)
			
			self.addEntrySuccessAlert(handler: { uia in
				self.performSegue(withIdentifier: "addedEntrySegue", sender: self)
			})
			// segue back to TrackerVC
			//			self.performSegue(withIdentifier: "addedEntrySegue", sender: self)
		} else {
			self.formNotCompleteAlert()
		}
	}
	
	func addEntrySuccessAlert(handler: ((UIAlertAction) -> Void)? = nil){
		// alert success
		// TextField alert taken from https://www.youtube.com/watch?v=xLWfJIYg2PM
		let alert = UIAlertController(
			title: "Success",
			message: "Entry Added",
			preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler ))
		self.present(alert, animated: true)
	}
	
	func formNotCompleteAlert(){
		// alert form not complete, no amt
		// TextField alert taken from https://www.youtube.com/watch?v=xLWfJIYg2PM
		let alert = UIAlertController(
			title: "Form not complete",
			message: "Make sure you entered amount greater than 0.00",
			preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
		self.present(alert, animated: true)
	}
	
	func noSubstancesAlert(handler: ((UIAlertAction) -> Void)? = nil){
		// alert form not complete, no amt
		// TextField alert taken from https://www.youtube.com/watch?v=xLWfJIYg2PM
		let alert = UIAlertController(
			title: "Can't add entry",
			message: "No substances.\nWould you like to go to Substances list?",
			preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Let's go", style: .default, handler: handler))
		self.present(alert, animated: true)
	}
	
	func auPickerCell(_ cell: AUPickerCell, didPick row: Int, value: Any) {
		switch row {
			case 0:
				// time and date
				guard let date = value as? Date else {
					print("AddEntryVC/auPickerCell: date selected == nil")
					return
				}
				self.datePicked = date
			default:
				// substance
				guard let sub = value as? String else {
					print("AddEntryVC/auPickerCell: string selected == nil")
					return
				}
				self.subSelectedStr? = sub
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		print("AddEntryVC/heightForRowAt(\(indexPath.row))")
		if indexPath.row == 0 || indexPath.row == 1{
			guard let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell else {
				print("AUPickerCell/guard: nil returning self.estimatedRowHeight") ////////////nil? cell is nil
				return self.estimatedRowHeight
			}
			return cell.height
		} else {
			//			return CGFloat(self.estimatedCellHeight)
			//			print("self.estimatedRowHeight=\(self.estimatedRowHeight)")
			return self.estimatedRowHeight
		}
		//		return super.tableView(tableView, heightForRowAt: indexPath)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		//		print("AddEntryVC/didSelectRowAt")
		if let cell = tableView.cellForRow(at: indexPath) as? AUPickerCell {
			cell.selectedInTableView(tableView)
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//		print("AddEntryVC/numberOfRowsInSection")
		return 3 // time, substance, amount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print("AddEntryVC/cellForRowAt")
		switch indexPath.row {
			case 0:
				// time and date
				let cell = AUPickerCell(type: .date, reuseIdentifier: "PickerDateCell")
				cell.delegate = self
				//				cell.separatorInset = UIEdgeInsets.zero
				//				var separatorColor: UIColor?
				cell.datePickerMode = .dateAndTime
				cell.date = self.datePicked // to make work set date and comment out cell.unexpandedHeight ?
				cell.dateStyle = .short
				cell.timeStyle = .short
				cell.leftLabel.text = "Date and Time:"
				cell.leftLabel.textColor = UIColor.lightText
				cell.rightLabel.textColor = UIColor.darkText
				cell.tintColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
				cell.backgroundColor = #colorLiteral(red: 0.6344745755, green: 0.5274511576, blue: 0.4317585826, alpha: 1)
				cell.separatorHeight = 1
				//				print("AddEntryVC/cellForRowAt(0): returing\n\(cell)")
				return cell
			case 1:
				print("case 1")
				return self.getPickerDefaultCell() //?
			// substance
			//				let cell = AUPickerCell(type: .default, reuseIdentifier: "PickerDefaultCell")
			//				cell.delegate = self
			////				cell.separatorInset = UIEdgeInsets.zero
			////				var separatorColor: UIColor?
			////				cell.leftLabel.constraint()
			//				cell.values = self.sm.subsAsStringArr()
			//				if cell.values.count == 0 {
			//					print("cell.values.count == 0")
			//					cell.values = ["No Substances"]
			//					cell.rightLabel.textColor = UIColor.red
			//				} else {
			//					print("cell.values.count != 0")
			//					cell.rightLabel.textColor = UIColor.darkText
			//				}
			//				cell.selectedRow = 0
			////				cell.sele
			//				// TODO: how to disable expanding? and then when I get
			//				//cell.setSelectedRow(0,false)
			//				cell.leftLabel.text = "Substance:"
			//				cell.leftLabel.textColor = UIColor.lightText
			//				cell.tintColor = #colorLiteral(red: 0.9382581115, green: 0.8733785748, blue: 0.684623003, alpha: 1)
			//				cell.backgroundColor = #colorLiteral(red: 0.6344745755, green: 0.5274511576, blue: 0.4317585826, alpha: 1)
			////				print("AddEntryVC/cellForRowAt(1): returing\n\(cell)")
			//				return cell
			default:
				// amount
				guard let cell = tableView.dequeueReusableCell(withIdentifier: AmountTableViewCell.reuseIdentifier, for: indexPath) as? AmountTableViewCell else {
					fatalError("Unexpected Index Path")
				}
				cell.textField.delegate = cell
				cell.stringWrapper = self.amountEnteredSW
				return cell
		}
		//		return cell
	}
}


// Wrap string so I can pass it by reference into AmountFieldTableViewCell
// and have cell edit the wrapped string and then use the edited amount
// in addEntryVC when add button pressed
class StringWrapper {
	var wrappedString = "Empty"
}



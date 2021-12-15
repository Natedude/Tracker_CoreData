//
//  SubstanceManager.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/14/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import CoreData
import CoreDataManager

class SubstanceManager {
	
	static let sharedInstance = SubstanceManager()
	private let cdm = CoreDataManager.sharedInstance
//	private let em: EntryManager// = EntryManager.sharedInstance
	var substances: [Substance] = []
	public static let format = DateFormatter()
	
	
	private init(){
		self.fetchSubstances()
		addTestSub()
	}
	
	func addTestSub(){
		//		let testS = Substance(name: "Test")
		let ctx = self.cdm.mainContext
		let seArr: [SubstanceEntity] = ctx.managerFor(SubstanceEntity.self).array as [SubstanceEntity]
		let testExist = seArr.filter{se in
			return se.name == "Test"
		}
		print("VC/addTestSub: subs with name 'Test' = \(testExist.count)")
		if(testExist.count == 0){
			_ = Substance(name: "Test")
			do {
				try ctx.saveIfChanged()
				print("addTestSub: SUCCESS")
			} catch {
				print("addTestSub() ERROR: \(error)")
			}
		}
	}
	
	// Sync db -> self.substances
	func fetchSubstances() {
		print("TrackerVC/fetchSubstances:")
		let ctx = self.cdm.mainContext
		let seArr: [SubstanceEntity] = ctx.managerFor(SubstanceEntity.self).array as [SubstanceEntity]
		self.substances = SubstanceEntity.seArr2sArr(seArr: seArr)
		
		//printing
		self.printSubstances()
		//		self.tableView.reloadData()
		print("------------------------------------END fetchSubstances\n")
	}
	
	func printSubstances(){
		print("TrackerVC/printSubstances:")
		_ = self.substances.map({
			(s: Substance) -> (Substance) in
			print(SubstanceEntity.toString(se: s.managedObject))
			return s
		})
		print("------------------------------------END printEntries\n")
	}
	
	func deleteAllSubstances(){
		let ctx = self.cdm.mainContext
		_ = ctx.managerFor(SubstanceEntity.self).delete()
		do{
			try ctx.saveIfChanged()
		} catch {
			print("TrackerVC/deleteAllSubstances: ctx.saveIfChanged() Error: \(error)")
		}
	}
	
	func getSubstances() -> [Substance] {
		return self.substances
	}
	
	func get(idx: Int) -> Substance {
		return self.substances[idx]
	}
	
	func count() -> Int {
		return self.substances.count
	}
	
}

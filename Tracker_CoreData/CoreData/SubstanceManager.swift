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
	
	// singleton pattern taken from https://krakendev.io/blog/the-right-way-to-write-a-singleton
	static let sharedInstance = SubstanceManager()
	private let cdm = CoreDataManager.sharedInstance
	var substances: [Substance] = []
//	public static let format = DateFormatter()
	
	private init(){
		self.fetchSubstances()
		addTestSub()
	}
	
	func subsAsStringArr() -> [String]{
		return self.substances.map{ s in
			return s.name
		} as [String]
	}
	
	func doesNameExist(name: String) -> Bool {
		let matches = self.substances.filter{ s in
			s.name == name
		}
		return matches.count > 0
	}
	
	func insertNewSub(name: String){
		print("SubstanceManager/insertNewSub:")
		if(!doesNameExist(name: name)){
			let context = self.cdm.mainContext
			let substance = Substance(name: name)
			
			print("Added Sub with name: \(substance.name)")
			print(substance.toString())
			do {
				try context.saveIfChanged()
				print("insertNewSub: SUCCESS")
			} catch {
				print("insertNewSub() ERROR: \(error)")
			}
			self.fetchSubstances()
		} else {
			print("Substance with name=\(name) already exists")
		}
		print("------------------------------------END insertNewSub\n")
		//		self.printEntries()
	}
	
	func getSubFromString(str: String) -> Substance? {
		let matchArr = self.substances.filter{ s in
			s.name == str
		}
		if(matchArr.count == 1){
			return matchArr[0]
		} else {
			// 0 matches
			return nil
		}
	}
	
	func addTestSub(){
		//		let testS = Substance(name: "Test")
		let ctx = self.cdm.mainContext
		let seArr: [SubstanceEntity] = ctx.managerFor(SubstanceEntity.self).array as [SubstanceEntity]
		let testExist = seArr.filter{se in
			return se.name == "Test"
		}
		print("SubstanceManager/addTestSub: subs with name 'Test' = \(testExist.count)")
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
		print("SubstanceManager/fetchSubstances:")
		let ctx = self.cdm.mainContext
		// might not need '.array' at end
		let seArr: [SubstanceEntity] = ctx.managerFor(SubstanceEntity.self).orderBy("name").array as [SubstanceEntity]
		self.substances = SubstanceEntity.seArr2sArr(seArr: seArr)
		
		//printing
		self.printSubstances()
		//		self.tableView.reloadData()
//		print("------------------------------------END fetchSubstances\n")
	}
	
	func printSubstances(){
		print("SubstanceManager/printSubstances:")
		_ = self.substances.map({ (s: Substance) -> (Substance) in
			print(s.toString())
			return s
		})
//		print("------------------------------------END printEntries\n")
	}
	
	func deleteAllSubstances(){
		let ctx = self.cdm.mainContext
		_ = ctx.managerFor(SubstanceEntity.self).delete()
		do{
			try ctx.saveIfChanged()
		} catch {
			print("SubstanceManager/deleteAllSubstances: ctx.saveIfChanged() Error: \(error)")
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

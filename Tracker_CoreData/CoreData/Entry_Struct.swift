//
//  Entry_Struct.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
import Foundation
import CoreData
import CoreDataManager

///////////////////////////////////////////////////////////////////////////////
/////////////////// ENTRY /////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

public struct Entry {
	var id: Int64
	var time: Date
	var substance: Substance
	var amount: String
	var managedObject: EntryEntity
	
	//turn MO into struct
	init?(entryEntity: EntryEntity) {
				print("EntryEntity/Entry()/init:")
		guard
			let id = entryEntity.value(forKey: "id") as? Int64 else {
				print("Entry/init(ee): id = nil")
				return nil
		}
		guard
			let t = entryEntity.value(forKey: "time") as? Date else {
				print("Entry/init(ee): time = nil")
				return nil
		}
		guard
			let sE = entryEntity.value(forKey: "substance") as? SubstanceEntity else {
				print("Entry/init(ee): substancEntity = nil")
				return nil
		}
//		guard
//			let a = entryEntity.value(forKey: "amount") as? String ///// nil
//			else {
//				print("Entry/init(ee): amount = nil")
//				return nil
//		}
		self.id = id
		self.time = t
		guard let s = Substance(substanceEntity: sE) else {
			print("Entry/init(ee)/init(ee): !!! ERROR return nil instead of Substance instance !!!")
			return nil
		}
		self.substance = s//Substance().managedObject
		let aMaybeNone = (entryEntity.value(forKey: "amount") ?? "none2") as! String
		print("Substance/init(sE): aMaybeNone = \(aMaybeNone)")
		self.amount = aMaybeNone
		self.managedObject = entryEntity
		self.managedObject.substance = sE
		self.managedObject.amount = aMaybeNone // no matter what I put it gets then null in db?
		//		print(self.toString() + "Entry(ee)/init SUCCESS")
		//		print("------------------------------------END init\n")
	}
	
	// create new MO by creating a struct
	init(id: Int64, time: Date, s: Substance, a: String) {
		self.managedObject = EntryEntity(context: CoreDataManager.sharedInstance.mainContext)
		self.managedObject.id = id
		self.managedObject.time = time
		self.managedObject.substance = s.managedObject
		self.managedObject.amount = a
		self.id = id
		self.time = time
		self.substance = s
		self.amount = a
	}
	
	//	init(){
	//		let s = Substance()
	//		let sMO = s.managedObject
	//		self.init(id: -1, time: Date(), sE: sMO)
	//	}
	
//	public static func toString(ee: EntryEntity) -> String{
//		//		print("EntryEntity/toString:")
//		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
//
//		return " ~  Entry: id=\(ee.id), time=\(timeStr), sub=\(ee.substance?.name ?? "nil, amount=\(ee.amount)")    ~~~~toString"
//	}
	
	// access fields so printing ee does not show <fault> and instead shows values
//	public static func realize(ee: EntryEntity){
//		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
//		_ = "\(ee)\nid:\(ee.id)\ntime:\(timeStr)\namount:\(ee.amount)"
//	}
	
//	func printEntry(){
//		Swift.print(EntryEntity.toString(ee: managedObject))
//	}
	
	func toString() -> String {
		return managedObject.toString()
	}
	
	func printEntry(){
		Swift.print(self.toString())
	}
	
	//	public static func printArr(eArr: [Entry]){
	//
	//	}
}

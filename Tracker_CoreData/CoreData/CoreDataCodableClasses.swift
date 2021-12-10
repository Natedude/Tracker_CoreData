//
//  CoreDataCodableClasses.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/8/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//
/*
* Codable NSManagedObjects Inspired by:
* https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
*/

import Foundation
import CoreData
import CoreDataManager

enum DecoderConfigurationError: Error {
	case missingCtx
}

extension CodingUserInfoKey {
	static let ctx = CodingUserInfoKey(rawValue: "ctx")!
}

///////////////////////////////////////////////////////////////////////////////
/////////////////// ENTRY /////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

public struct Entry {
	var id: Int64
	var time: Date
	var managedObject: EntryEntity
	
	//turn MO into struct
	init?(entryEntity: EntryEntity) {
		guard
			let id = entryEntity.value(forKey: "id") as? Int64,
			let time = entryEntity.value(forKey: "time") as? Date
			else {
				return nil
			}
		self.id = id
		self.time = time
		self.managedObject = entryEntity
	}
	
	// create new MO by creating a struct
	init(id: Int64, time: Date) {
		self.managedObject = EntryEntity(context: CoreDataManager.sharedInstance.mainContext)
		self.id = id
		self.time = time
	}
	
	init(){
		self.init(id: -1, time: Date())
	}
}

@objc(EntryEntity)
public class EntryEntity: NSManagedObject {
	public func getEntry() -> Entry{
		let eOpt = Entry(entryEntity: self) //Entry?
		guard let e = eOpt else {
			return Entry()
		}
		return e
	}
	
	public static func printArr(eeArr: [EntryEntity]){
		print("EntryEntity/printArr:")
		_ = eeArr.map({
			(ee: EntryEntity) -> (EntryEntity) in
			EntryEntity.realize(ee: ee)
			print(ee)
			return ee
		})
		print()
	}
	
	public static func toString(ee: EntryEntity) -> String{
		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
		return "\(ee)\nid:\(ee.id)\ntime:\(timeStr)"
	}
	
	// access fields so printing ee does not show <fault> and instead shows values
	public static func realize(ee: EntryEntity){
		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
		_ = "\(ee)\nid:\(ee.id)\ntime:\(timeStr)"
	}
	// maybe instead of Entry having a init that makes an Entry from a MO,
	// I could have EntryEntity have an Entry field
	// it would create it when
	// and a getEntry method
	
	public static func ArrToEntryArr(entityArr: [EntryEntity?]) -> [Entry]{
		print("EntryEntity/ArrToEntryArr:")
		let filtered = entityArr.filter({
			(e:EntryEntity?) -> (Bool) in
			if(e == nil){
//				print("EntryEntity/ArrToEntryArr/filter: e is nil")
				return false
			} else {
				self.realize(ee: e!)
				print(e!)
				return true
			}
		})
//		print("EntryEntity/ArrToEntryArr/filtered: \(filtered)")
		if (filtered.count == 0){
			return []
		} else {
			// get array of unwrapped Es from EEs
			return filtered.map({
				(ee:EntryEntity?) -> Entry in  // ! used bc checked if nil in filter
//				print( EntryEntity.toString(ee: e!) )
				let e = Entry(entryEntity: ee!)
				guard let finalEntry = e else {
					return Entry() // <------------------ This is maybe ERROR TODO:
				}
				return finalEntry
			})
		}
	}
}

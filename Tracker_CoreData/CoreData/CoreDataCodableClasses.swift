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
	var substance: SubstanceEntity
	var managedObject: EntryEntity
	
	//turn MO into struct
	init?(entryEntity: EntryEntity) {
//		print("EntryEntity/Entry()/init:")
		guard
			let id = entryEntity.value(forKey: "id") as? Int64,
			let time = entryEntity.value(forKey: "time") as? Date
//			let substance = entryEntity.value(forKey: "substance") as? SubstanceEntity
			else {
				print("Entry()/init: !!! ERROR return nil instead of Entry instance !!!")
				return nil
			}
		self.id = id
		self.time = time
		self.substance = Substance().managedObject
		self.managedObject = entryEntity
//		print(EntryEntity.toString(ee: entryEntity) + "Entry(ee)/init SUCCESS")
//		print("------------------------------------END init\n")
	}
	
	// create new MO by creating a struct
	init(id: Int64, time: Date, sE: SubstanceEntity) {
		self.managedObject = EntryEntity(context: CoreDataManager.sharedInstance.mainContext)
		self.managedObject.id = id
		self.managedObject.time = time
		self.id = id
		self.time = time
		self.substance = sE
	}
	
	init(){
		let s = Substance()
		let sMO = s.managedObject
		self.init(id: -1, time: Date(), sE: sMO)
	}
	
//	public static func printArr(eArr: [Entry]){
//
//	}
}

@objc(EntryEntity)
public class EntryEntity: NSManagedObject, Codable {
//	let this = self
//	let entry = Entry(entryEntity: self.this)
	
	enum CodingKeys: CodingKey {
		case id, time, substance
	}

	required convenience public init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.ctx] as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingCtx
		}

		self.init(context: context) // constructor that accepts a ctx and adds EE into ctx and returns it

		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int64.self, forKey: .id)
		self.time = try container.decode(Date.self, forKey: .time)
		self.substance = try container.decode(SubstanceEntity.self, forKey: .substance)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(time, forKey: .time)
		try container.encode(substance, forKey: .substance)
	}
	
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
		print("------------------------------------END printArr\n")
	}
	
	public static func toString(ee: EntryEntity) -> String{
//		print("EntryEntity/toString:")
		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
		return " ~  Entry: id=\(ee.id), time=\(timeStr)    ~~~~toString"
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

	/////////////////////////////////////////////////////////////////////////////// eeArr2eArr
	/////////////////// eeArr2eArr ///////////////////////////////////////////////////// FOCUS ---
	/////////////////////////////////////////////////////////////////////////////// eeArr2eArr
	public static func eeArr2eArr(eeArr: [EntryEntity]) -> [Entry]{
//		print("EntryEntity/eeArr2eArr:")
		let len = eeArr.count
		var eArr: [Entry] = []
		//		print("len=\(len)")
		for i in 0...(len-1) {
			//			print(eeArr[i])
			let eOpt = Entry(entryEntity: eeArr[i]) //not actually calling the constructor?
			guard let e = eOpt else {
				print("""
					TrackerVC/eeArr2eArr: !!! ERROR i = \(i)
					&& `guard let e = eOpt == NIL -> true` !!!
					""")
				break;
			}
			eArr.append(e)
		}
		if eArr.count > 0 {
			print("eeArr2eArr: SUCCESS - type(eArr) = \(type(of: eArr))")
			print("------------------------------------END eeArr2eArr\n")
			return eArr
		} else {
			// failure
			print("eeArr2eArr: FAILURE")
			return []
		}
		//		print("------------------------------------END eeArr2eArr\n")
	}
//	public static func ArrToEntryArr(entityArr: [EntryEntity?]) -> [Entry]{
//
//		print("EntryEntity/ArrToEntryArr:")
//		let filtered = entityArr.filter({
//			(e:EntryEntity?) -> (Bool) in
//			if(e == nil){
////				print("EntryEntity/ArrToEntryArr/filter: e is nil")
//				return false
//			} else {
////				print("EntryEntity/ArrToEntryArr/filter: e is non-nil")
////				print("\(e!)\nid: \(e!.id)\ntime: \(e!.time!.description)")
////				self.realize(ee: e!)
//				print(EntryEntity.toString(ee: e!))
////				print(e!)
////				print("\(e)\nid:\(e.id)\ntime:\(e.time.description)")
//				return true
//			}
//		})
////		print("EntryEntity/ArrToEntryArr/filtered: \(filtered)")
//		if (filtered.count == 0){
//			print("------------------------------------END ArrToEntryArr\n")
//			return []
//		} else {
//			// get array of unwrapped Es from EEs
//			return filtered.map({
//				(ee:EntryEntity?) -> Entry in  // ! used bc checked if nil in filter
//				print( EntryEntity.toString(ee: ee!) )
//
//				let e = Entry(entryEntity: ee!) //this is coming back nil ERROR
//
//				guard let finalEntry = e else {
//					print("EntryEntity/ArrToEntryArr/map: ERROR returning Fake Entry")
//					print("------------------------------------END ArrToEntryArr\n")
//					return Entry()
//				}
//				print("------------------------------------END ArrToEntryArr\n")
//				return finalEntry
//			})
//		}
//
//	}
}

///////////////////////////////////////////////////////////////////////////////
/////////////////// SUBSTANCE /////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

public struct Substance {
	var name: String
	var entries: [Entry]
	var managedObject: SubstanceEntity
	
	//turn MO into struct
	init?(substanceEntity: SubstanceEntity) {
		guard
			let name = substanceEntity.value(forKey: "name") as? String
//			let entries = substanceEntity.value(forKey: "entries") as? NSSet
			else {
				return nil
		}
		self.name = name
//		self.entries = substanceEntity.entriesArray //TODO:
		self.entries = []
		self.managedObject = substanceEntity
	}
	
	// create new MO by creating a struct
	init(name: String){
		self.name = name
		self.entries = []
		self.managedObject = SubstanceEntity(context: CoreDataManager.sharedInstance.mainContext)
		self.managedObject.name = name
		self.managedObject.entries = []
	}
	
	init(){
		self.init(name: "Fake_Substance")
	}
}


@objc(SubstanceEntity)
public class SubstanceEntity: NSManagedObject, Codable {
	enum CodingKeys: CodingKey {
		case name, entries
	}

	required convenience public init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.ctx] as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingCtx
		}

		self.init(context: context)

		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.entries = try container.decode(Set<EntryEntity>.self, forKey: .entries) as NSSet
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(entries as? Set<EntryEntity>, forKey: .entries)
	}

//	public var entriesArray: [Entry] {
//		let set = entries as? Set<EntryEntity> ?? []
//		let sorted = set.sorted {
//			$0.id < $1.id
//			//might want to switch to a > so that more recent ids come first
//		}
//		return EntryEntity.ArrToEntryArr(entityArr: sorted)
//	}
	
	public static func ArrToSubstanceArr(entityArr: [SubstanceEntity]) -> [Substance]{
		let filtered = entityArr.filter({
			(s:SubstanceEntity?) -> (Bool) in
			return s == nil ? false : true
		})
		if (filtered.count == 0){
			return []
		} else {
			return filtered.map({
				(s:SubstanceEntity) -> Substance in
				return Substance(substanceEntity: s)! // checked if nil in filter
			})
		}
	}
}

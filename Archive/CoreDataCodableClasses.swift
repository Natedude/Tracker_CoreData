////
////  CoreDataCodableClasses.swift
////  Tracker_CoreData
////
////  Created by Nathan Hildum on 12/8/21.
////  Copyright © 2021 Nathan Hildum. All rights reserved.
////
////
///*
//* Codable NSManagedObjects Inspired by:
//* https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
//*/
//
//import Foundation
//import CoreData
//import CoreDataManager
//
//enum DecoderConfigurationError: Error {
//	case missingCtx
//}
//
//extension CodingUserInfoKey {
//	static let ctx = CodingUserInfoKey(rawValue: "ctx")!
//}
//
/////////////////////////////////////////////////////////////////////////////////
///////////////////// ENTRY /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
//
//public struct Entry {
//	var id: Int64
//	var time: Date
//	var substance: Substance
//	var managedObject: EntryEntity
//	
//	//turn MO into struct
//	init?(entryEntity: EntryEntity) {
////		print("EntryEntity/Entry()/init:")
//		guard
//			let id = entryEntity.value(forKey: "id") as? Int64,
//			let time = entryEntity.value(forKey: "time") as? Date,
//			let sE = entryEntity.value(forKey: "substance") as? SubstanceEntity
//			else {
//				print("Substance/init(sE): !!! ERROR return nil instead of SubstanceEntity instance !!!")
//				return nil
//			}
//		self.id = id
//		self.time = time
//		guard let s = Substance(substanceEntity: sE) else {
//			print("Substance/init(sE): !!! ERROR return nil instead of Substance instance !!!")
//			return nil
//		}
//		self.substance = s//Substance().managedObject
//		self.managedObject = entryEntity
//		self.managedObject.substance = sE
////		print(EntryEntity.toString(ee: entryEntity) + "Entry(ee)/init SUCCESS")
////		print("------------------------------------END init\n")
//	}
//	
//	// create new MO by creating a struct
//	init(id: Int64, time: Date, s: Substance) {
//		self.managedObject = EntryEntity(context: CoreDataManager.sharedInstance.mainContext)
//		self.managedObject.id = id
//		self.managedObject.time = time
//		self.managedObject.substance = s.managedObject
//		self.id = id
//		self.time = time
//		self.substance = s
//	}
//	
////	init(){
////		let s = Substance()
////		let sMO = s.managedObject
////		self.init(id: -1, time: Date(), sE: sMO)
////	}
//	
//	func printEntry(){
//		Swift.print(EntryEntity.toString(ee: managedObject))
//	}
//	
////	public static func printArr(eArr: [Entry]){
////
////	}
//}
//
//@objc(EntryEntity)
//public class EntryEntity: NSManagedObject, Codable {
////	let this = self
////	let entry = Entry(entryEntity: self.this)
//	
//	enum CodingKeys: CodingKey {
//		case id, time, substance
//	}
//
//	required convenience public init(from decoder: Decoder) throws {
//		guard let context = decoder.userInfo[CodingUserInfoKey.ctx] as? NSManagedObjectContext else {
//			throw DecoderConfigurationError.missingCtx
//		}
//
//		self.init(context: context) // constructor that accepts a ctx and adds EE into ctx and returns it
//
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		self.id = try container.decode(Int64.self, forKey: .id)
//		self.time = try container.decode(Date.self, forKey: .time)
//		self.substance = try container.decode(SubstanceEntity.self, forKey: .substance)
//	}
//
//	public func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//		try container.encode(id, forKey: .id)
//		try container.encode(time, forKey: .time)
//		try container.encode(substance, forKey: .substance)
//	}
//	
//	// maybe instead of Entry having a init that makes an Entry from a MO,
//	// I could have EntryEntity have an Entry field
//	// it would create it when
//	// and a getEntry method
////	public func getEntry() -> Entry{
////		let eOpt = Entry(entryEntity: self) //Entry?
////		guard let e = eOpt else {
////			return Entry()
////		}
////		return e
////	}
//	
//	public static func printArr(eeArr: [EntryEntity]){
//		print("EntryEntity/printArr:")
//		_ = eeArr.map({
//			(ee: EntryEntity) -> (EntryEntity) in
//			EntryEntity.realize(ee: ee)
//			print(ee)
//			return ee
//		})
//		print("------------------------------------END printArr\n")
//	}
//	
//	public static func toString(ee: EntryEntity) -> String{
////		print("EntryEntity/toString:")
//		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
//		
//		return " ~  Entry: id=\(ee.id), time=\(timeStr), sub=\(ee.substance?.name ?? "nil")    ~~~~toString"
//	}
//	
//	// access fields so printing ee does not show <fault> and instead shows values
//	public static func realize(ee: EntryEntity){
//		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
//		_ = "\(ee)\nid:\(ee.id)\ntime:\(timeStr)"
//	}
//
//	// convert [EntryEntity] to [Entry] to more easily manage structs
//	public static func eeArr2eArr(eeArr: [EntryEntity]) -> [Entry]{
////		print("EntryEntity/eeArr2eArr:")
//		let len = eeArr.count
//		// checking len solves the
//		// Fatal error cannot create Range
//		// in case CoreData has no entries
//		if(len == 0){
//			print("eeArr2eArr: input eeArr EMPTY")
//			return []
//		}
//		var eArr: [Entry] = []
//		//		print("len=\(len)")
//		for i in 0...(len-1) {
//			//			print(eeArr[i])
//			let eOpt = Entry(entryEntity: eeArr[i]) //not actually calling the constructor?
//			guard let e = eOpt else {
//				print("""
//					TrackerVC/eeArr2eArr: !!! ERROR i = \(i)
//					&& `guard let e = eOpt == NIL -> true` !!!
//					""")
//				break;
//			}
//			eArr.append(e)
//		}
//		if eArr.count > 0 {
//			print("eeArr2eArr: SUCCESS - type(eArr) = \(type(of: eArr))")
//			print("------------------------------------END eeArr2eArr\n")
//			return eArr
//		} else {
//			// failure
//			print("eeArr2eArr: FAILURE")
//			return []
//		}
//		//		print("------------------------------------END eeArr2eArr\n")
//	}
//	
////	public static eeOptArr2eeArr(eeOptArr: [EntryEntity?]) -> [EntryEntity]{
////
////	}
//}
//
/////////////////////////////////////////////////////////////////////////////////
///////////////////// SUBSTANCE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
//// NSSet(array: [Any])
//
//public struct Substance {
//	static var count = 0
//	var name: String
//	var entries: [Entry]
//	var managedObject: SubstanceEntity
//	
//	//turn MO into struct
//	init?(substanceEntity: SubstanceEntity) {
//		guard
//			let name = substanceEntity.value(forKey: "name") as? String
////			let entries = substanceEntity.value(forKey: "entries") as? Set<EntryEntity>
//			else {
//				return nil
//		}
//		self.name = name
////		Substance.count += 1
////		print("Substance/init(sE): Substance.count=\(Substance.count) entries=\n\(entries)")
//		self.entries = []
////		print("Substance/init(se): self.entries = \(self.entries)")
////		self.entries = EntryEntity.eeArr2eArr(eeArr: eeArr) //TODO:
////		self.entries = []
//		self.managedObject = substanceEntity
//	}
//	
//	func realizeEntries(){
////		guard
////			var entries = managedObject.value(forKey: "entries") as? Set<EntryEntity>
////			else {
////				return
////		}
////		let eeOptArr = entries.map{ee in
////			return Entry(entryEntity: ee)
////		}
////		entries = Array(eeOptArr.filter{ eOpt in
////			return eOpt != nil
////		}.map{ eOpt in
////			return eOpt!
////		}) as [Entry]
//	}
//	
//	// create new MO by creating a struct
//	init(name: String){
//		self.name = name
//		self.entries = []
//		self.managedObject = SubstanceEntity(context: CoreDataManager.sharedInstance.mainContext)
//		self.managedObject.name = name
//		self.managedObject.entries = []
//	}
//	
//	init(){
//		self.init(name: "Fake_Substance")
//		print("Substance/init(): name = 'Fake_Substance'")
//	}
//}
//
//
//@objc(SubstanceEntity)
//public class SubstanceEntity: NSManagedObject, Codable {
//	enum CodingKeys: CodingKey {
//		case name, entries
//	}
//
//	required convenience public init(from decoder: Decoder) throws {
//		guard let context = decoder.userInfo[CodingUserInfoKey.ctx] as? NSManagedObjectContext else {
//			throw DecoderConfigurationError.missingCtx
//		}
//
//		self.init(context: context)
//
//		let container = try decoder.container(keyedBy: CodingKeys.self)
//		self.name = try container.decode(String.self, forKey: .name)
//		self.entries = try container.decode(Set<EntryEntity>.self, forKey: .entries) as Set<EntryEntity>
//	}
//
//	public func encode(to encoder: Encoder) throws {
//		var container = encoder.container(keyedBy: CodingKeys.self)
//		try container.encode(name, forKey: .name)
//		try container.encode(entries, forKey: .entries)
//	}
//	
//	// convert [EntryEntity] to [Entry] to more easily manage structs
//	public static func seArr2sArr(seArr: [SubstanceEntity]) -> [Substance]{
//		print("SubstanceEntity/seArr2sArr:")
//		let len = seArr.count
//		// checking len solves the
//		// Fatal error cannot create Range
//		// in case CoreData has no entries
//		if(len == 0){
//			print("seArr2sArr: input seArr EMPTY")
//			return []
//		}
//		var sArr: [Substance] = []
//		//		print("len=\(len)")
//		for i in 0...(len-1) {
//			//			print(eeArr[i])
//			let eOpt = Substance(substanceEntity: seArr[i]) //not actually calling the constructor?
//			guard let s = eOpt else {
//				print("""
//					SubstanceEntity/seArr2sArr: !!! ERROR i = \(i)
//					&& `guard let s = eOpt == NIL -> true` !!!
//					""")
//				break;
//			}
//			sArr.append(s)
//		}
//		if sArr.count > 0 {
//			print("eeArr2eArr: SUCCESS - type(eArr) = \(type(of: sArr))")
//			print("------------------------------------END seArr2sArr\n")
//			return sArr
//		} else {
//			// failure
//			print("eeArr2eArr: FAILURE")
//			print("------------------------------------END seArr2sArr\n")
//			return []
//		}
//	}
//	
//	public static func toString(se: SubstanceEntity) -> String{
//		print("SubstanceEntity/toString:")
//		guard let name = se.name else {
//			print("ERROR se.name is nil")
//			return "No Name"
//		}
//		return " ~  Substance: name=\(name)    ~~~~toString"
//	}
//}

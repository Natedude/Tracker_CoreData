//
//  EntryEntity+CoreDataClass.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EntryEntity)
public class EntryEntity: NSManagedObject, Codable {
	//	let this = self
	//	let entry = Entry(entryEntity: self.this)
	
	enum CodingKeys: CodingKey {
		case id, time, substance, amount
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
		self.amount = try container.decode(String.self, forKey: .amount)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(time, forKey: .time)
		try container.encode(substance, forKey: .substance)
		try container.encode(amount, forKey: .amount)
	}
	
	// maybe instead of Entry having a init that makes an Entry from a MO,
	// I could have EntryEntity have an Entry field
	// it would create it when
	// and a getEntry method
	//	public func getEntry() -> Entry{
	//		let eOpt = Entry(entryEntity: self) //Entry?
	//		guard let e = eOpt else {
	//			return Entry()
	//		}
	//		return e
	//	}
	
//	public static func toString(ee: EntryEntity) -> String{
//		//		print("EntryEntity/toString:")
//		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
//
//		return " ~  Entry: id=\(ee.id), time=\(timeStr), sub=\(ee.substance?.name ?? "nil, amount=\(ee.amount)")    ~~~~toString"
//	}
	
	func toString() -> String{
		print("EntryEntity/toString: buh")
		let timeStr: String = self.time == nil ? "No Date" : self.time!.description
		
		let amount: String = self.amount == nil ? "ee.toString" : self.amount!
		
		return " ~  Entry: id=\(self.id), time=\(timeStr), sub=\(self.substance?.name ?? "nil"), amount=\(amount)                  ~~~~toString"
	}
	
	// access fields so printing ee does not show <fault> and instead shows values
	public static func realize(ee: EntryEntity){
		let timeStr: String = ee.time == nil ? "No Date" : ee.time!.description
		_ = "\(ee)\nid:\(ee.id)\ntime:\(timeStr)\namount:\(ee.amount ?? "nil")"
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
	
	// convert [EntryEntity] to [Entry] to more easily manage structs
	public static func eeArr2eArr(eeArr: [EntryEntity]) -> [Entry]{
		print("EntryEntity/eeArr2eArr:")
		let len = eeArr.count
		// checking len solves the
		// Fatal error cannot create Range
		// in case CoreData has no entries
		if(len == 0){
			print("eeArr2eArr: input eeArr EMPTY")
			return []
		}
//		self.realize(ee: eeArr[0])
//		print("eeArr2eArr: input eeArr = \(eeArr)")
		
		var eArr: [Entry] = []
		//		print("len=\(len)")
		for i in 0...(len-1) {
			//			print(eeArr[i])
			let eOpt = Entry(entryEntity: eeArr[i]) //not actually calling the constructor?
			guard let e = eOpt else { // this is returning nil
				print("EntryEntity/eeArr2eArr: eOpt = nil      ERROR!!!!!!!!!!!")
//				print("""
//					EntryEntity/eeArr2eArr: !!! ERROR i = \(i)
//					&& `guard let e = eOpt == NIL -> true` !!!
//					""")
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
			print("eeArr2eArr: eeArr EMPTY")
			return []
		}
		print("------------------------------------END eeArr2eArr\n")
	}
	
	//	public static eeOptArr2eeArr(eeOptArr: [EntryEntity?]) -> [EntryEntity]{
	//
	//	}
}

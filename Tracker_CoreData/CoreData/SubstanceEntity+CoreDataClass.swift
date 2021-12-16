//
//  SubstanceEntity+CoreDataClass.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import CoreData
import CoreDataManager

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
		self.entries = try container.decode(Set<EntryEntity>.self, forKey: .entries) as Set<EntryEntity>
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(entries, forKey: .entries)
	}
	
	// convert [EntryEntity] to [Entry] to more easily manage structs
	public static func seArr2sArr(seArr: [SubstanceEntity]) -> [Substance]{
		print("SubstanceEntity/seArr2sArr:")
		let len = seArr.count
		// checking len solves the
		// Fatal error cannot create Range
		// in case CoreData has no entries
		if(len == 0){
			print("seArr2sArr: input seArr EMPTY")
			return []
		}
		var sArr: [Substance] = []
		//		print("len=\(len)")
		for i in 0...(len-1) {
			//			print(eeArr[i])
			let eOpt = Substance(substanceEntity: seArr[i]) //not actually calling the constructor?
			guard let s = eOpt else {
				print("""
					SubstanceEntity/seArr2sArr: !!! ERROR i = \(i)
					&& `guard let s = eOpt == NIL -> true` !!!
					""")
				break;
			}
			sArr.append(s)
		}
		if sArr.count > 0 {
			print("eeArr2eArr: SUCCESS - type(eArr) = \(type(of: sArr))")
			print("------------------------------------END seArr2sArr\n")
			return sArr
		} else {
			// failure
			print("eeArr2eArr: FAILURE")
			print("------------------------------------END seArr2sArr\n")
			return []
		}
	}
	
	// static
//	public static func toString(se: SubstanceEntity) -> String{
//		print("SubstanceEntity/toString:")
//		guard let name = se.name else {
//			print("ERROR se.name is nil")
//			return "No Name"
//		}
//		return " ~  Substance: name=\(name)    ~~~~toString"
//	}
	
	//instance
	func toString() -> String{
//		print("SubstanceEntity/toString:")
		guard let name = self.name else {
			print("ERROR se.name is nil")
			return "No Name"
		}
		return " ~  Substance: name=\(name)    ~~~~toString"
	}
}

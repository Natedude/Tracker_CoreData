//
//  Entry+CoreDataClass.swift
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

enum DecoderConfigurationError: Error {
	case missingCtx
}

extension CodingUserInfoKey {
	static let ctx = CodingUserInfoKey(rawValue: "ctx")!
}

@objc(EntryMO)
public class Entry: NSManagedObject, Codable {
	enum CodingKeys: CodingKey {
		case id, time, substance
	}
	
	required convenience public init(from decoder: Decoder) throws {
		guard let context = decoder.userInfo[CodingUserInfoKey.ctx] as? NSManagedObjectContext else {
			throw DecoderConfigurationError.missingCtx
		}
		
		self.init(context: context)
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int64.self, forKey: .id)
		self.time = try container.decode(Date.self, forKey: .time)
		self.substance = try container.decode(Substance.self, forKey: .substance)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(time, forKey: .time)
		try container.encode(substance, forKey: .substance)
	}
}

@objc(SubstanceMO)
public class Substance: NSManagedObject, Codable {
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
		self.entries = try container.decode(Set<Entry>.self, forKey: .entries) as NSSet
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(entries as? Set<Entry>, forKey: .entries)
	}
	
	public var entriesArray: [Entry] {
		let set = entries as? Set<Entry> ?? []
		return set.sorted {
			$0.id < $1.id
			//might want to switch to a > so that more recent ids come first
		}
	}
}

//struct Entry: Decodable {
//	var medName: String
//	var time: Date
//	var substance: SubstanceMO
//
//	init?(entryMO: NSManagedObject) {
//		guard
//			let medName = entryMO.value(forKey: "medName") as? String,
//			let time = entryMO.value(forKey: "time") as? Date,
//			let substance = entryMO.value(forKey: "substance") as? SubstanceMO
//		else {
//			return nil
//		}
//		self.medName = medName
//		self.time = time
//		self.substance = substance
//	}
//}

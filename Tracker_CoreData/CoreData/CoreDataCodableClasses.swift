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
	var time: Date
	var substance: SubstanceEntity
	
	init?(entryEntity: EntryEntity) {
		guard
			let time = entryEntity.value(forKey: "time") as? Date,
			let substance = entryEntity.value(forKey: "substance") as? SubstanceEntity
			else {
				return nil
		}
		self.time = time
		self.substance = substance
	}
}

@objc(EntryEntity)
public class EntryEntity: NSManagedObject, Codable {
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
		self.substance = try container.decode(SubstanceEntity.self, forKey: .substance)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(time, forKey: .time)
		try container.encode(substance, forKey: .substance)
	}
}

///////////////////////////////////////////////////////////////////////////////
/////////////////// SUBSTANCE /////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

public struct Substance {
	var name: String
	var entries: [EntryEntity]
	
	init?(substanceEntity: SubstanceEntity) {
		guard
			let name = substanceEntity.value(forKey: "name") as? String,
			let entries = substanceEntity.value(forKey: "entries") as? NSSet
			else {
				return nil
		}
		self.name = name
		self.entries = Array(entries) as! [EntryEntity]
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

	public var entriesArray: [Entry] {
		let set = entries as? Set<EntryEntity> ?? []
		let sorted = set.sorted {
			$0.id < $1.id
			//might want to switch to a > so that more recent ids come first
		}
		let filtered = sorted.filter({
			(e:EntryEntity?) -> (Bool) in
			return e == nil ? false : true
		})
		if (filtered.count == 0){
			return []
		} else {
			return filtered.map({
				(e:EntryEntity) -> Entry in
				return Entry(entryEntity: e)! // checked if nil in filter
			})
		}
	}
}

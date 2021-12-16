//
//  Substance_Struct.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 12/15/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import CoreData
import CoreDataManager

///////////////////////////////////////////////////////////////////////////////
/////////////////// SUBSTANCE /////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
// NSSet(array: [Any])

public struct Substance {
	static var count = 0
	var name: String
	var entries: [Entry]
	var managedObject: SubstanceEntity
	
	//turn MO into struct
	init?(substanceEntity: SubstanceEntity) {
		guard
			let name = substanceEntity.value(forKey: "name") as? String
			//			let entries = substanceEntity.value(forKey: "entries") as? Set<EntryEntity>
			else {
				return nil
		}
		self.name = name
		//		Substance.count += 1
		//		print("Substance/init(sE): Substance.count=\(Substance.count) entries=\n\(entries)")
		self.entries = []
		//		print("Substance/init(se): self.entries = \(self.entries)")
		//		self.entries = EntryEntity.eeArr2eArr(eeArr: eeArr) //TODO:
		//		self.entries = []
		self.managedObject = substanceEntity
	}
	
	func realizeEntries(){
		//		guard
		//			var entries = managedObject.value(forKey: "entries") as? Set<EntryEntity>
		//			else {
		//				return
		//		}
		//		let eeOptArr = entries.map{ee in
		//			return Entry(entryEntity: ee)
		//		}
		//		entries = Array(eeOptArr.filter{ eOpt in
		//			return eOpt != nil
		//		}.map{ eOpt in
		//			return eOpt!
		//		}) as [Entry]
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
		print("Substance/init(): name = 'Fake_Substance'")
	}
	
	func toString() -> String {
		return managedObject.toString()
	}
}

//
//  CoreDataManager.swift
//  Tracker_CoreData
//
//  Created by Nathan Hildum on 11/24/21.
//  Copyright © 2021 Nathan Hildum. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
	
	// Singleton pattern so there is only ever one CDM in the project
	// - do I also want to put the persistentContainer in this? or the context?
	class var shared : CoreDataManager {
		struct Singleton {
			static let instance = CoreDataManager()
		}
		return Singleton.instance
	}
	
	//***********************************************************************
	// MARK: - Core Data stack
	//***********************************************************************
	
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Tracker_CoreData")
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error {
				fatalError("Loading of store failed \(error)")
			}
		}
		return container
	}()
	
	//***********************************************************************
	// MARK: - Default managed-Object Context
	//***********************************************************************
	
	// make the content available so don't need to keep on making AppDelegate.persistentContainer.viewContext
	// who else needs ctx? viewDidLoad
	// ! now the persistent container is in this class
	// I need both this and managedObjectContext bc I want to unwrap the option managedObjectContext returns and return that
	private func getContext() -> NSManagedObjectContext?{
		let opt_ctx: NSManagedObjectContext? = self.persistentContainer.viewContext
		guard let ctx = opt_ctx else {
			print("context() ERROR: self.managedObjectContext == nil")
			return nil
		}
		return ctx
	}
	
	private lazy var context: NSManagedObjectContext = {
		return self.getContext()!
//		return (ctx != nil) ? ctx! : nil
	}()
	
	//***********************************************************************
	// MARK: - Core Data CRUD Functions
	// Create, Read, Update, Delete
	//***********************************************************************
	
	func saveContext () -> Bool {
//		let context = persistentContainer.viewContext
		if self.context.hasChanges {
			do {
				try self.context.save()
				return true
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
		return false
	}

	
	//	func saveContext (managedObjectContext: NSManagedObjectContext?) ->Bool {
//		var isdataSaved:Bool = true
//		//Manage Object Context
//		let ctx = self.context
//
//		var error: NSError? = nil
//		if ctx.hasChanges && !ctx.save() {
//			// Replace this implementation with code to handle the error appropriately.
//			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//			isdataSaved = false
//			NSLog("Unresolved error while Saving \(error), \(error!.userInfo)")
//			abort()
//		}
//
//		return isdataSaved
//	}
	
	//***********************************************************************
	// MARK: - INSERT
	//***********************************************************************
	func insertDataForEntity(entityName:String, withEntityData data:Dictionary<String,AnyObject>, withManageObjectContext managedObjectContext:NSManagedObjectContext?, withInstantUpdate needToSaveNow:Bool) -> NSManagedObject{
		//Manage Object Context
//		let moc = self.defaultManagedObjectContext(managedObjectContext)
		
		//Create empty object
		let managedObject: NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: self.context) as NSManagedObject
		return self.updateDataForManagedObject(managedObject: managedObject, withEntityData: data, withManageObjectContext: managedObjectContext, withInstantUpdate: needToSaveNow)
	}
	
	//***********************************************************************
	// MARK: - FETCH
	//***********************************************************************
	func selectDataForEntity(entityName:String, withPredicate predicate:NSPredicate?, withSortDescriptors sortDescriptors:Array<AnyObject>?, withManageObjectContext managedObjectContext:NSManagedObjectContext?) ->Array<AnyObject>?{
		
		// Create fetch request
		let fetchRequest: NSFetchRequest =
			NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		fetchRequest.predicate = predicate
		fetchRequest.sortDescriptors = sortDescriptors as? [NSSortDescriptor]
		fetchRequest.fetchBatchSize = 20
		
		//Manage Object Context
		//let moc = self.defaultManagedObjectContext(managedObjectContext)
		do {
			return try
				self.context.fetch(fetchRequest) as Array<AnyObject>
		} catch {
			fatalError("Failed to fetch employees: \(error)")
		}
		
//		return self.context.fetch(fetchRequest) as Array<AnyObject>
	}
	
	//***********************************************************************
	// MARK: - UPDATE
	//***********************************************************************
	func updateDataForManagedObject(managedObject:NSManagedObject, withEntityData data:Dictionary<String,AnyObject>, withManageObjectContext managedObjectContext:NSManagedObjectContext?, withInstantUpdate needToSaveNow:Bool) -> NSManagedObject{
		//Keys
		let keys = (managedObject.entity.attributesByName as Dictionary).keys
		//Set Values
		for key in keys {
			if let value: AnyObject = data[key as String] {
				managedObject.setValue(value, forKey: key as String)
				//println("\(key) \t \(value)")
			}
		}

		//Need to save
		if needToSaveNow {
			//Manage Object Context
//			let moc = self.context
			//save now
			if self.saveContext() {
				print("managedObject data saved")
			}else{
				print("Failed to save to data store")
			}
		}
		return managedObject
	}
//
//	//***********************************************************************
//	// MARK: - DELETE(All)
//	//***********************************************************************
//	func deleteManagedObject(managedObject:NSManagedObject?, withManageObjectContext managedObjectContext:NSManagedObjectContext?, withInstantUpdate needToSaveNow:Bool) ->Bool{
//		var isdeleted:Bool = true
//		//check Object
//		if let deletedObject = managedObject {
//			//Manage Object Context
//			let moc = self.defaultManagedObjectContext(managedObjectContext)
//			//delete now
//			moc.deleteObject(deletedObject)
//			//Need to save
//			if needToSaveNow {
//				isdeleted = self.saveContext(moc)
//			}
//		}else {
//			println("managedObject is nil,which you are trying to delete")
//			isdeleted = false
//		}
//
//		//Return
//		return isdeleted
//	}
//
//	func deleteAllManagedObjectsFromEntity(entityName:String, withPredicate predicate:NSPredicate?, withManageObjectContext managedObjectContext:NSManagedObjectContext?, withInstantUpdate needToSaveNow:Bool) ->Bool{
//		var isdeleted:Bool = true
//
//		// Create fetch request
//		let fetchRequest: NSFetchRequest = NSFetchRequest()
//		//Manage Object Context
//		let moc = self.defaultManagedObjectContext(managedObjectContext)
//		//Entity
//		let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: moc)!
//		fetchRequest.entity = entityDescription
//		// Ignore property values for maximum performance
//		fetchRequest.includesPropertyValues = false
//		//set predicate
//		if let deleteAllPredicate = predicate {
//			fetchRequest.predicate = deleteAllPredicate
//		}
//
//		// Execute the request
//		var error: NSError? = nil
//		let fetchRequestResults: Array<AnyObject>? = moc.executeFetchRequest(fetchRequest, error: &error)
//		//chk nil
//		if let fetchResults = fetchRequestResults {
//			for managedObject in fetchResults {
//				//delete now
//				moc.deleteObject(managedObject as NSManagedObject)
//			}
//		}else {
//			println("Couldn't delete managedObjects for entity-name \(entityName)")
//			isdeleted = false
//		}
//
//		//Need to save
//		if needToSaveNow {
//			isdeleted = self.saveContext(moc)
//		}
//
//		//Return
//		return isdeleted
//	}
	
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
	
	// Sync db -> self.entries
	// reloadData'
	// TODO: turn into fetch and have VC make a fetchRequest
//	func fetchEntries(ctx: NSManagedObjectContext) {
//		// - get entries into array
//		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entry")
//		do {
//			self.entries = try ctx.fetch(fetchRequest)
//			print("fetchEntries:")
//			self.printEntries()
//		} catch let error as NSError {
//			print("Could not fetch. \(error), \(error.userInfo)")
//		}
//	}
//
//	func fetch(){
//
//
//	}
	
	// Create new row in Entry table
	// save
//	func createEntry(medName: String) {
//		print("save: called")
//		guard let appDelegate =
//			UIApplication.shared.delegate as? AppDelegate else {
//				return
//		}
//		let ctx = appDelegate.persistentContainer.viewContext
//
//		let entity = NSEntityDescription.entity(forEntityName: "Entry",in: ctx)!
//		let newEntry = NSManagedObject(entity: entity, insertInto: ctx)
//		newEntry.setValue(medName, forKeyPath: "medName")
//		print("save: newEntry = \(newEntry)")
//		do {
//			try ctx.save()
//			self.entries.append(newEntry)
//			print("save: appended. entries:")
//			self.printEntries()
//		} catch let error as NSError {
//			print("Could not save. \(error), \(error.userInfo)")
//		}
//	}
	
}

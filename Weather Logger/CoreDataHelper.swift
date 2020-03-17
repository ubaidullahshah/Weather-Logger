//
//  CoreDataHelper.swift
//  Nagham
//
//  Created by Syed Ubaid Khan on 8/9/16.
//  Copyright © 2016 Syed Ubaid Khan. All rights reserved.
//

import UIKit
import CoreData
@available(iOS 10.0, *)
class CoreDataHelper: NSObject {
    
    @objc static let sharedInstance = CoreDataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    fileprivate override init() {
        super.init()
    }
    
    
    @objc func saveContext() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    @objc func resetContext() {
        context.reset()
    }
    
    @objc func refreshObject(_ managedObject: NSManagedObject) {
        context.refresh(managedObject, mergeChanges: false)
    }
    
    @objc func refreshObject() {
        context.refreshAllObjects()
    }
    
    @objc func deleteObject(_ managedObject: NSManagedObject) {
        context.delete(managedObject)
    }
    
    @objc func deleteObjects(managedObjects: [NSManagedObject]) {
        for item in managedObjects {
            context.delete(item)
        }
    }
    
    @objc func initEntityWithName(_ entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: self.context)
    }
    
    @objc func fetchAll(entity: String) -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        let fetchedData:[NSManagedObject]!
        do {
            fetchedData = try context.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            fatalError("Failed to fetch : \(error)")
        }
        return fetchedData
    }
    
    @objc func fetch(entity: String, predicate: NSPredicate) -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = predicate
        let fetchedData:[NSManagedObject]!
        do {
            fetchedData = try context.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            fatalError("Failed to fetch : \(error)")
        }
        return fetchedData
    }
    
    @objc func fetchInOrderAdded(entity: String, keyname: String) -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let sortDescriptor = NSSortDescriptor(key: keyname, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedData:[NSManagedObject]!
        do {
            fetchedData = try context.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            fatalError("Failed to fetch : \(error)")
        }
        return fetchedData
    }
    
    @objc func fetchInOrderAlphabatical(entity: String, predicate: NSPredicate, keyname: String) -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let sortDescriptor = NSSortDescriptor(key: keyname, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        let fetchedData:[NSManagedObject]!
        do {
            fetchedData = try context.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            fatalError("Failed to fetch : \(error)")
        }
        return fetchedData
    }
    
    
    
    /*func fetchAll<T>(type:T.Type) -> [T] {
     
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type(of: T.self)))
     
     let fetchedData:[T]!
     do {
     fetchedData = try managedObjectContext.fetch(fetchRequest) as! [T]
     } catch {
     fatalError("Failed to fetch : \(error)")
     }
     return fetchedData
     }*/
    
    
}

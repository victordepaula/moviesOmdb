//
//  AbstractData.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//
import UIKit
import CoreData


class AbstractData: NSObject {
    enum Entity: String {
        case movies = "Movies"
    }
    
    enum Attributtes : String {
        case profile = "id"
    }
    
    var entityName: String!
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(_ data: [String: Any]) -> Any? {
        let managedContext = getContext()
        let entity = NSEntityDescription.entity(forEntityName: entityName , in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        for key in data.keys {
            let value = data[key]
            object.setValue(value, forKey: key)
        }
        do {
            let response = try managedContext.save()
            return response
        } catch let error as NSError {
            return error
        }
    }
    
    func get() -> Any {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults =  false
        do {
            let response = try managedContext.fetch(fetchRequest)
            return response
            
        } catch let error as NSError {
            return error
        }
    }
    
    func getMovieId(_ value: String?, atributte: Attributtes?) -> Any {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if let value1 = value, let atribute1 = atributte {
            fetchRequest.predicate = NSPredicate(format: "\(atribute1.rawValue) == %@", value1)
        }
        fetchRequest.returnsObjectsAsFaults =  false
        do {
            let response = try managedContext.fetch(fetchRequest)
            return response
        } catch let error as NSError {
            return error
        }
    }
    
    func removeMovieWithId(value: String?, attribute: Attributtes?) -> Bool {
        let managedContext = getContext()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        fetchRequest.predicate = NSPredicate(format: "\(attribute!.rawValue) == %@", value!)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject
                managedContext.delete(managedObjectData)
                print("Detele data for userID in \(entityName) Successfully")
                try managedContext.save()
                return true
            }
        } catch let error as NSError {
            print("Detele data for userID in \(entityName) error : \(error) \(error.userInfo)")
            
        }
        return false
    }

    
    func removeAll(){
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entityName) error : \(error) \(error.userInfo)")
            
        }
    }
}


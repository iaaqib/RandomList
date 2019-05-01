//
//  CoreDataManager.swift
//  RandomList
//
//  Created by Aaqib Hussain on 24/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import CoreData

class CoreDataManager: NSObject {
    
    static let sharedInstance = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "RandomList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Deleting support
    
    func purgeData() {
        do {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Products.className)
            let fetchRequestImages = NSFetchRequest<NSFetchRequestResult>(entityName: Image.className)
            do {
                let objects  = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
                let imageObjects  = try managedObjectContext.fetch(fetchRequestImages) as? [NSManagedObject]
                _ = objects.map{$0.map{managedObjectContext.delete($0)}}
                _ = imageObjects.map{$0.map{managedObjectContext.delete($0)}}
                saveContext()
            } catch let error {
                print("error while purging data: \(error)")
            }
        }
    }
    
}

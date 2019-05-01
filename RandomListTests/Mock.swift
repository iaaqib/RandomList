//
//  MockAPIManager.swift
//  RandomListTests
//
//  Created by Aaqib Hussain on 24/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import Foundation
import CoreData

// MARK: - APIManager Mock

class MockAPIManager: APIManager {
   
    override func request(urlRequest: Router, success: @escaping (Data) -> (), failure: @escaping (Error) -> ()) {
        guard let json = loadJson(url: urlRequest.urlRequest!.url!) else {return}
        success(json)
    }
    
    private func loadJson(url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url, options: .dataReadingMapped)
            return data
        } catch {
            // handle error
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CoreDataManager Mock

class MockCoreDataManager: CoreDataManager {
  
    override var managedObjectContext: NSManagedObjectContext {
        return managedObjectContextLazy
    }
    
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }
        catch {
            coordinator = nil
            print("Error")
        }
        
        return coordinator
    }()
    
    override func purgeData() {
        
    }
    
    override func saveContext() {
        
    }
}

// MARK: - Router Mock

//Provides the data from the source in bundle
enum FilePathRouter: Router {
   
    case getProducts
   
    var path: String {
        return "Products"
    }
    
    func asURLRequest() throws -> URLRequest {
        let path = Bundle.main.path(forResource: self.path, ofType: "json")
        let fileURL = URL(fileURLWithPath: path!)
        let url = URLRequest(url: fileURL)
        return url
    }
}

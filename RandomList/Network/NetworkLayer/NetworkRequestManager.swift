//
//  NetworkRequestManager.swift
//  RandomList
//
//  Created by Aaqib Hussain on 23/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//
import UIKit
import CoreData

class NetworkRequestManager: NSObject {
   
    // MARK: - Dependency vars
    
    private let apiManager: APIManager
    private let coreDataManager: CoreDataManager
    
    // MARK: - Init
    
    init(apiManager: APIManager = APIManager(), coreDataManager: CoreDataManager = CoreDataManager.sharedInstance) {
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Function
    
    func request<T: Decodable>(router: Router, success:@escaping (_ response: T)->(), failure:@escaping (_ error: Error)->()) {
        apiManager.request(urlRequest: router, success: { (data) in
            self.coreDataManager.purgeData()
            guard let model = try? JSONDecoder.init(context: self.coreDataManager.managedObjectContext).decode(T.self, from: data) else {
               let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error while trying to parse model"])
                failure(error)
                return
            }
            success(model)
            self.coreDataManager.saveContext()
        }, failure: failure)

    }
    
}


//
//  RandomListViewModel.swift
//  RandomList
//
//  Created by Aaqib Hussain on 24/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import Foundation
import CoreData

class RandomListViewModel: NSObject {
    
    // MARK: - Vars
    
    //To give callbacks to ViewController
    var displayActivityIndicator: (_ status: Bool) -> ()
    var displayMessage: (_ message: String) -> ()
    var reloadData: () -> ()
    
    private let manager: NetworkRequestManager
    private let coreDataManager: CoreDataManager
    private(set) var products: [Products] = []
    private lazy var searchedProducts: [Products] = []
    
    private lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Products.className)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "prodName", ascending: true)]
        let fetchRequestC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchRequestC
    }()
    
    
    var numberOfRows: Int {
        return self.products.count
    }
    
    // MARK: - Init
    
    init(manager: NetworkRequestManager = NetworkRequestManager(), coreDataManager: CoreDataManager = CoreDataManager.sharedInstance) {
        self.manager = manager
        self.coreDataManager = coreDataManager
        displayActivityIndicator = { _ in }
        displayMessage = { _ in }
        reloadData = { }
    }
    
    // MARK: - Functions
    
    //Returns object at a provided index
    func getItemAtIndex(index: Int) -> Products {
        return products[index]
    }
    
    //Fetches all the products from server
    func getRandomProducts(router: Router = ProductsRouter.getProducts) {
        displayActivityIndicator(true)
        manager.request(router: router, success: { [weak self] (model: RootProduct) in
            guard let `self` = self, let prods = model.products else { return }
            self.products = prods
            self.displayActivityIndicator(false)
            self.reloadData()
        }) { [weak self] (error) in
            guard let `self` = self else { return }
            self.displayActivityIndicator(false)
            self.displayMessage(error.localizedDescription)
            print(error.localizedDescription)
        }
    }
    
    //Fetches all the products from CoreData if exists otherwise from server
    func fetchProducts() {
        do {
            try self.fetchedhResultController.performFetch()
            if let products = self.fetchedhResultController.fetchedObjects as? [Products], products.count > 0 {
                self.products = products
                return
            } else {
                getRandomProducts()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Searching
    func searchProductByName(text: String) {
        if searchedProducts.count == 0 {
            searchedProducts = products
        }
        //Filters all the products
        products = searchedProducts.filter({ (product) -> Bool in
            guard let prodName: NSString = product.prodName as NSString? else {return false}
            let range = prodName.range(of: text, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        //Set the original array if there is no data filtered
        if products.count == 0 {
            products = searchedProducts
        }
        reloadData()
    }
    
}

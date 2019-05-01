//
//  Products+CoreDataProperties.swift
//  
//
//  Created by Aaqib Hussain on 23/4/19.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var prodName: String?
    @NSManaged public var orignalPrice: String?
    @NSManaged public var currentPrice: String?
    @NSManaged public var brand: String?
    @NSManaged public var image: Image?
    @NSManaged public var currency: String?

}

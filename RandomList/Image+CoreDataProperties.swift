//
//  Image+CoreDataProperties.swift
//  
//
//  Created by Aaqib Hussain on 23/4/19.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var url: String?
    @NSManaged public var id: String?

 
}

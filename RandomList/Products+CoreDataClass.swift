//
//  Products+CoreDataClass.swift
//  
//
//  Created by Aaqib Hussain on 23/4/19.
//
//

import Foundation
import CoreData

@objc(Products)
public class Products: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case brand = "brand"
        case currency = "currency"
        case currentPrice = "current_price"
        case identifier = "identifier"
        case image
        case name = "name"
        case originalPrice = "original_price"
        case products
    }
    
    
    
    required public convenience init(from decoder: Decoder) throws {
        let context = decoder.userInfo[CodingUserInfoKey.context!] as! NSManagedObjectContext //else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: Products.className, in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.prodName = try container.decodeIfPresent(String.self, forKey: .name)
        
        self.currentPrice = String(describing: try container.decodeIfPresent(Double.self, forKey: .currentPrice) ?? 0.0)
        self.orignalPrice = String(describing: try container.decodeIfPresent(Double.self, forKey: .originalPrice) ?? 0.0)
        self.brand = try container.decodeIfPresent(String.self, forKey: .brand)
        self.image = try container.decodeIfPresent(Image.self, forKey: .image)
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(prodName, forKey: .name)
        try container.encode(currentPrice, forKey: CodingKeys.currentPrice)
        try container.encode(orignalPrice, forKey: .originalPrice)
        try container.encode(brand, forKey: .brand)
        try container.encode(currency, forKey: .currency)
        try container.encode(image, forKey: .image)
        
    }
    
    func productDescription() -> String {
        let name = self.prodName ?? "NA"
        let brand = self.brand ?? "NA"
        let currentPrice = self.currentPrice ?? "NA"
        let originalPrice = self.orignalPrice ?? "NA"
        let currency = self.currency ?? "NA"
        var desc = ""
        if currentPrice == originalPrice {
            desc = "Name: \(name)\nBrand: \(brand)\nOriginal Price: \(originalPrice) \(currency)"
        } else {
            desc = "Name: \(name)\nBrand: \(brand)\nOriginal Price: \(originalPrice) \(currency)\nCurrent Price: \(currentPrice) \(currency)"
        }
        return desc
    }
}

class RootProduct : Codable {
    
    let products : [Products]?
    
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
    }
    
}

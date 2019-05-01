//
//  Image+CoreDataClass.swift
//  
//
//  Created by Aaqib Hussain on 23/4/19.
//
//

import Foundation
import CoreData

@objc(Image)
public class Image: NSManagedObject, Codable {
    
    var asURL: URL? {
        return URL(string: url ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
    }
    
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: "Image", in: context) else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.id = String(describing: try container.decodeIfPresent(Int.self, forKey: .id))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
    }
}


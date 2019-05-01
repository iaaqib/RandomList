//
//  Extension.swift
//  RandomList
//
//  Created by Aaqib Hussain on 24/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}


extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[CodingUserInfoKey.context!] = context
    }
}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}

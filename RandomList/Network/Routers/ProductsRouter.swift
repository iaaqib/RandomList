//
//  ProductsRouter.swift
//  RandomList
//
//  Created by Aaqib Hussain on 23/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import Foundation

enum ProductsRouter: Router {
    
    case getProducts

    var path: String {
        return "/products"
    }

}


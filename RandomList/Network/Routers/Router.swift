//
//  Router.swift
//  RandomList
//
//  Created by Aaqib Hussain on 23/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible  {
    
    var path: String { get }
    var params: [String : Any] { get }
}

extension Router {
    
    var baseURL: String {
        return "https://private-91dd6-iosassessment.apiary-mock.com"
    }

    var params: [String : Any] {
        return [:]
    }

    func asURLRequest() throws -> URLRequest {
        let url = try self.baseURL.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        return try URLEncoding.default.encode(urlRequest, with: self.params)
    }
}



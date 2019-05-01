//
//  APIManager.swift
//  RandomList
//
//  Created by Aaqib Hussain on 23/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import Alamofire

class APIManager: NSObject {
    
    func request(urlRequest: Router, success:@escaping (_ response: Data)->(), failure:@escaping (_ error: Error)->()) {
        Alamofire.request(urlRequest).responseData { (response) in
            if let data = response.data, data.count > 0 {
                success(data)
            } else if let error = response.error {
                failure(error)
            }
        }
    }
}

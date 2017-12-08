//
//  Service.swift
//  Sample-MockingJayPod
//
//  Created by Christopher Grantham on 12/7/17.
//  Copyright © 2017 Ronaldo Gomes. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    
    func get(callback: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        Alamofire.request("http://domain/api/test").responseString { response in
            if let value = response.result.value {
                callback(value)
            } else {
                failure("Error!!!")
            }
        }
    }    
    
}

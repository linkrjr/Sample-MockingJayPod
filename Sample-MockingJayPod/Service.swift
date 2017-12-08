//
//  Service.swift
//  Sample-MockingJayPod
//
//  Created by Christopher Grantham on 12/7/17.
//  Copyright © 2017 Ronaldo Gomes. All rights reserved.
//

import Foundation
import Alamofire

struct Message: Codable, Equatable {
    var text: String
    
    func ==(lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text
    }
}

class Service {
    
    func get(callback: @escaping (Message) -> Void, failure: @escaping (String) -> Void) {
        Alamofire.request("http://domain/api/test").responseJSON { response in
            
            if response.result.isSuccess, let value = response.data {
                let decoder = JSONDecoder()
                let message = try! decoder.decode(Message.self, from: value)
                callback(message)
            } else {
                failure("Error!!!")
            }
        }
    }    
    
}

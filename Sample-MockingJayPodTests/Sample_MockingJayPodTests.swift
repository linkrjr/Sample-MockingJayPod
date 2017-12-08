//
//  Sample_MockingJayPodTests.swift
//  Sample-MockingJayPodTests
//
//  Created by Christopher Grantham on 12/7/17.
//  Copyright © 2017 Ronaldo Gomes. All rights reserved.
//

import XCTest
import Mockingjay
import Quick
import Nimble

@testable import Sample_MockingJayPod

class Sample_MockingJayPodTests: QuickSpec {
    
    override func spec() {
        
        describe("Testing MockingJay pod") {
            let body = ["body":"Hello, MockingJay!!!"]
            
            beforeEach {
//                stub(uri("/api/test"), builder: json("Hello, MockingJay!!!"))
                
                self.stub(http(.get, uri: "/api/test"), delay: nil, json(body))
                
//                MockingjayProtocol.addStub(matcher: http(.get, uri: "/api/test"), builder: json("Hello, MockingJay!!!"))
            }
            
            context("Trying to stub a GET request") {
                
                it("should make a get request!!") {
                    
                    let fetchExpectingMessage = self.expectation(description: "Fetch Message")
                    let service = Service()
                    
                    service.get(callback: { value in
                        
                        expect(value).to(equal(body["body"]))
                        fetchExpectingMessage.fulfill()
                        
                    }, failure: { error in
                        
                    })
                    
                    self.waitForExpectations(timeout: 5, handler: nil)
                }
                
            }
            
        }
        
    }
    
}

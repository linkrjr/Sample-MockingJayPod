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
            let body = ["text":"Hello, MockingJay!!!"]
            
            context("Trying to stub a GET request") {
                
                beforeEach {
                    //                stub(uri("/api/test"), builder: json("Hello, MockingJay!!!"))
                    
                    self.stub(http(.get, uri: "/api/test"), delay: nil, json(body))
                    
                    //                MockingjayProtocol.addStub(matcher: http(.get, uri: "/api/test"), builder: json("Hello, MockingJay!!!"))
                }
                
                it("should make a get request!!") {
                    
                    let fetchExpectingMessage = self.expectation(description: "Fetch Message")
                    let service = Service()
                    
                    service.get(callback: { message in
                        
                        expect(message == Message(text: "Hello, MockingJay!!!")).to(beTrue())
                        fetchExpectingMessage.fulfill()
                        
                    }, failure: { error in
                        fatalError()
                    })
                    
                    self.waitForExpectations(timeout: 5, handler: nil)
                }
                
            }
            
            context("Testing the error handling path") {
                
                beforeEach {

                    let serverErrorStub = http(500, headers: nil, download: .noContent)
                    
                    self.stub(http(.get, uri: "/api/test"), delay: nil, serverErrorStub)
                    
                }

                it("should fail the reqeust with the proper message") {
                    
                    let fetchExpectingMessage = self.expectation(description: "Fetch Message")
                    let service = Service()
                    
                    service.get(callback: { message in
                        fatalError()
                    }, failure: { error in

                        expect(error).to(equal("Error!!!"))
                        fetchExpectingMessage.fulfill()
                        
                    })
                    
                    self.waitForExpectations(timeout: 5, handler: nil)
                }
                
            }
            
        }
        
    }
    
}

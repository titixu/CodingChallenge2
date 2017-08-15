//
//  ObjectFetchingTests.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 Test API calls
 */

import XCTest

@testable import CodeChallenge2

class ObjectFetchingTests: XCTestCase {
    
    let catagoryURL  = URL(string: "https://pastebin.com/raw/8LiEHfwU")!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCategoryAPI() {
        let aExpectation = expectation(description: "test category API")
        
        let objectFetcher = ObjectFetcher(url: self.catagoryURL)
        objectFetcher.fetch { (data: Data?, error: Error?) in
            XCTAssert(error == nil, error!.localizedDescription)
            XCTAssert(data != nil, error!.localizedDescription)
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [JSON]
            
            XCTAssert(json != nil, "Error converting data to json object")
            
            aExpectation.fulfill()
        }
        
         waitForExpectations(timeout: 5.0) { (error: Error?) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
    }
    
}

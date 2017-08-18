//
//  ObjectFetchingTests.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 Test API calls and mapping object structors
 */

import XCTest

@testable import CodeChallenge2

class ObjectFetchingTests: XCTestCase {
    
    let catagoryURL = URL(string: "https://pastebin.com/raw/8LiEHfwU")!
    
    func testCategoryAPI() {
        
        let aExpectation = expectation(description: "test category API")
        
        let objectFetcher = ObjectFetcher(url: self.catagoryURL)
        
        objectFetcher.fetch { (data: Data?, error: Error?) in
            
            XCTAssert(error == nil, error!.localizedDescription)
            
            XCTAssert(data != nil, error!.localizedDescription)
            
            // TODO: also compare the data with data.json
            let jsons = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [JSON]
            
            XCTAssert(jsons != nil, "Error converting data to json object")
            
            // test the json mapping
            for json in jsons! {
                
                let category = try? Category(json: json)
                
                XCTAssert(category != nil, "error createing category")
                
                XCTAssertNotNil(category??.items.first?.imageCollection.portraitURL, "Missing portrait url")
                
                XCTAssertNotNil(category??.items.first?.imageCollection.landscapeURL, "Missing lanscape url")
            }
            
            aExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (error: Error?) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
    }
    
}

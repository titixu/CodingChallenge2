//
//  CachedImageTests.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 testing images download and cacheing image locally
 */

import UIKit
import XCTest

@testable import CodeChallenge2

class CachedImageTests: XCTestCase {
    
    let portraitImageURL = URL(string: "https://image.tmdb.org/t/p/w640/gfJGlDaHuWimErCr5Ql0I8x9QSy.jpg")!
    
    let landscapeImageURL = URL(string: "https://image.tmdb.org/t/p/original/hA5oCgvgCxj5MEWcLpjXXTwEANF.jpg")!
    
    let fileManager = FileManager.default
        
    func testRemoveCachedImageFolder() {
        
        ImageFetcher.removeAllCachedImage()
        
        let fileExists = fileManager.fileExists(atPath: ImageFetcher.appCachedImageFolderURL()!.path)
        
        XCTAssert(fileExists == false , "False to remove image cache folder")
    }
    
    func testPortraitImageDownlaod() {
        
        ImageFetcher.removeAllCachedImage()
        
        let aExpectation = expectation(description: "test image download")
        
        let imageFetcher = ImageFetcher(imageURL: portraitImageURL)
        
        imageFetcher.fetchImage { (image: UIImage?, url: URL) in
            
            XCTAssert(image != nil, "No image from \(url)")
            
            //make sure image is cached
            let cachedImage = imageFetcher.cachedImage(forRemoteFileURL: url)
            XCTAssert(cachedImage != nil, "Image not cached \(url)")
            
            aExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 60.0) { (error: Error?) in
            XCTAssert(error == nil, error!.localizedDescription)
            ImageFetcher.removeAllCachedImage() //clean up
        }
    }
    
    func testLandscapeImageDownlaod() {
        
        ImageFetcher.removeAllCachedImage()
        
        let aExpectation = expectation(description: "test image download")
        
        let imageFetcher = ImageFetcher(imageURL: landscapeImageURL)
        
        imageFetcher.fetchImage { (image: UIImage?, url: URL) in
            
            XCTAssert(image != nil, "No image from \(url)")
            
            //make sure image is cached
            let cachedImage = imageFetcher.cachedImage(forRemoteFileURL: url)
            
            XCTAssert(cachedImage != nil, "Image not cached \(url)")
            
            aExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 60.0) { (error: Error?) in
            
            XCTAssert(error == nil, error!.localizedDescription)
            
            ImageFetcher.removeAllCachedImage()//clean up
        }
    }
    
}

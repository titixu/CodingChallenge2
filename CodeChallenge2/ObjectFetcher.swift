//
//  ObjectFetcher.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 All API calls are in the background thread
 */

import Foundation

// default timeout is too long, use 10 seconds
private let timeOut = 10.0

class ObjectFetcher {
    
    var url: URL
    
    init(url: URL) {
        
        self.url = url
    }
    
    func fetch(completionHandler: @escaping (Data?, Error?) -> Swift.Void) {
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data: Data?, _: URLResponse?, error: Error?) in
            
            completionHandler(data, error)
        }
        
        task.resume()
    }
    
    // ideal for image download
    func fetchWithLocalCache(completionHandler: @escaping (Data?, Error?) -> Swift.Void) {
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: timeOut)
        
        let task = session.dataTask(with: request) { (data: Data?, _: URLResponse?, error: Error?) in
            
            completionHandler(data, error)
        }
        
        task.resume()
    }
    
}

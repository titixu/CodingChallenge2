//
//  ObjectFetcher.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

class ObjectFetcher {
    
    var url: URL
    
    init(url: URL) {
        
        self.url = url
    }
    
    func fetch(completionHandler:@escaping (Data?, Error?) -> Swift.Void) {
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            completionHandler(data, error)
        }
        
        task.resume()
    }
    
    //ideal for image download
    func fetchWithLocalCache(completionHandler: @escaping (Data?, Error?) -> Swift.Void) {
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        
        let task = session.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            
            completionHandler(data, error)
        }
        
        task.resume()
    }
    
}

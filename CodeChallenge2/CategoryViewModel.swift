//
//  CategoryViewModel.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

class CategoryViewModel {
    
    let catagoryURL  = URL(string: "https://pastebin.com/raw/8LiEHfwU")!
    
    var categorys = [Category]()
    
    lazy var objectFetcher: ObjectFetcher = {
        
        return ObjectFetcher(url: self.catagoryURL)
    }()
    
    func loadData(completionHandler: @escaping (Error?) -> ()) {
        
        objectFetcher.fetch { (data: Data?, error: Error?) in
            
            if let data = data {
                
                if let jsons = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [JSON] {
                    
                    self.categorys = [] //clean up old categorys data
                    
                    for json in jsons {
                        
                        do {
                            
                            let category = try Category(json: json)
                            
                            //Feature category always at the top
                            if category!.isFeatured == true {
                                
                                self.categorys.insert(category!, at: 0)
                                
                            } else {
                                
                                self.categorys.append(category!)
                            }
                        }  catch {
                            
                            print("Unable to creat category object from \(json)")
                        }
                    }
                }
            }
            
            completionHandler(error)
        }
        
    }
    
    
}

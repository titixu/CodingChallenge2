//
//  Category.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

fileprivate enum JSONKey: String {
    
    case title = "category"
    
    case items
}

class Category: JSONMappable {
    
    var title = ""
    
    var items = [MediaItem]()
    
    var isFeatured: Bool {
        
        return self.title == "Features"
    }
    
    required init?(json: JSON) throws {
        
        guard let title = json[JSONKey.title.rawValue] as? String,
            let items = json[JSONKey.items.rawValue] as? [JSON] else {
            
            throw JSONParingError.valuesMissing
        }
        
        self.title = title
        
        for json in items {
            
            do {
                
                let item = try MediaItem(json: json)
                
                self.items.append(item!)
                
            } catch {
                
                print(error.localizedDescription)
            }
            
        }
        
    }
}

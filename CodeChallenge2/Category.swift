//
//  Category.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

fileprivate enum JsonKey: String {
    case title = "category"
    case items = "items"
}

class Category: JSONMappable {
    
    var title = ""
    var items = [MediaItem]()
    
    required init?(json: JSON) {
        
        guard let title = json[JsonKey.title.rawValue] as? String,
        let items = json[JsonKey.items.rawValue] as? [JSON]
            else {
                return nil
        }
        
        self.title = title
        
        for json in items {
            if let item = MediaItem(json: json) {
                self.items.append(item)
            }
        }
        
    }
}

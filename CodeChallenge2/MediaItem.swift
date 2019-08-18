//
//  MediaItem.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

fileprivate enum JSONKey: String {
    
    case title
    
    case year
    
    case description
    
    case imageCollection = "images"
}

class MediaItem: JSONMappable {
    
    var title = ""
    
    var year = 0
    
    var description = ""
    
    var imageCollection: ImageCollection
    
    required init?(json: JSON) throws {
        
        guard let title = json[JSONKey.title.rawValue] as? String,
            let year = json[JSONKey.year.rawValue] as? NSNumber,
            let description = json[JSONKey.description.rawValue] as? String,
            let images = json[JSONKey.imageCollection.rawValue] as? JSON else {
            
            throw JSONParingError.valuesMissing
        }
        
        self.title = title
        
        self.year = year.intValue
        
        self.description = description
        
        guard let imageCollection = try? ImageCollection(json: images) else {
            
            throw JSONParingError.valuesMissing
        }
        
        self.imageCollection = imageCollection
        
    }
    
}

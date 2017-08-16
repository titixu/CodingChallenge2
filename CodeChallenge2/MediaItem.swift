//
//  MediaItem.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

fileprivate enum JsonKey: String {
    
    case title = "title"
    case year = "year"
    case description = "description"
    case imageCollection = "images"
}

class MediaItem: JSONMappable {
    
    var title = ""
    var year = 0
    var description = ""
    var imageCollection : ImageCollection
    
    required init?(json: JSON) throws {
        
        guard let title = json[JsonKey.title.rawValue] as? String,
            let year = json[JsonKey.year.rawValue] as? NSNumber,
            let description = json[JsonKey.description.rawValue] as? String,
            let images = json[JsonKey.imageCollection.rawValue] as? JSON else {
                
                throw JsonParingError.JSONValuesMissing
        }
        
        self.title = title
        self.year = Int(year)
        self.description = description
        
        guard let imageCollection = try? ImageCollection(json:images) else {
            
            throw JsonParingError.JSONValuesMissing
        }
        
        self.imageCollection = imageCollection!
        
    }
    
}

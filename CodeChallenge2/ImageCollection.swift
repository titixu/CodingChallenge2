//
//  ImageCollection.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

fileprivate enum JsonKey: String {
    
    case portrait = "portrait"
    
    case landscape = "landscape"
}

class ImageCollection: JSONMappable {
    
    var portraitURL: URL?
    
    var landscapeURL: URL?
    
    required init?(json: JSON) throws {
        
        guard let portrait = json[JsonKey.portrait.rawValue] as? String,
            let landscape = json[JsonKey.landscape.rawValue] as? String else {
                
                throw JsonParingError.JSONValuesMissing
        }
        
        portraitURL = URL(string: portrait)
        
        landscapeURL = URL(string: landscape)
    }
    
}

//
//  ImageCollection.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

fileprivate enum JSONKey: String {
    
    case portrait
    
    case landscape
}

class ImageCollection: JSONMappable {
    
    var portraitURL: URL?
    
    var landscapeURL: URL?
    
    required init?(json: JSON) throws {
        
        guard let portrait = json[JSONKey.portrait.rawValue] as? String,
            let landscape = json[JSONKey.landscape.rawValue] as? String else {
            
            throw JSONParingError.valuesMissing
        }
        
        portraitURL = URL(string: portrait)
        
        landscapeURL = URL(string: landscape)
    }
    
}

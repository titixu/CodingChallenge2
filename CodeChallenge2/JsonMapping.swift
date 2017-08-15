//
//  JsonMapping.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol JSONMappable {
    
    //create instance from a json dictionary
    init?(json: JSON)
    
    //dictionaryRepresentation currently not required for this demo
    //    func json() -> JSON
}

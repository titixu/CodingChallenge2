//
//  AlertFactory.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 This class create different kind of alert controllers
 */

import Foundation
import UIKit

extension UIAlertController {
    
    //A simple UIAlertController with just a message and an "OK" button. Idea for showing an error message to user
    static func alert(description: String) -> UIAlertController {
        let ac = UIAlertController(title: nil, message: description, preferredStyle: .alert)
        let actiont = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(actiont)
        return ac
    }
}

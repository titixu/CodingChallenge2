//
//  UIViewController+AlertHandler.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import Foundation
import UIKit

/*
 Cpmvemoemt functions to display alert message in view controller
 */

extension UIViewController {
    
    func displayAlert(message: String) {
        
        let alert = UIAlertController.alert(description: message)
        
        present(alert, animated: true, completion: nil)
    }
}

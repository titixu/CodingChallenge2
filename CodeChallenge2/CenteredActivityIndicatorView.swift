//
//  CenteredActivityIndicatorView.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
 A spinner in the middle from its super view, indicating loading
 */

import UIKit

class CenteredBlueActivityIndicatorView: UIActivityIndicatorView {
    
    override init(style: UIActivityIndicatorView.Style) {
        
        super.init(style: style)
        
        color = UIColor.blue
        
        hidesWhenStopped = true
    }
    
    required init(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    func activateDefaultConstraints(superView view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

//
//  CenteredActivityIndicatorView.swift
//  CodeChallenge2
//
//  Created by SamXu on 15/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class CenteredBlueActivityIndicatorView: UIActivityIndicatorView {

    override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
        color = UIColor.blue
        hidesWhenStopped = true
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func defaultConstraints(superView view: UIView) -> [NSLayoutConstraint] {
        
        let centerXConstraint = centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYConstraint = centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        return [centerXConstraint, centerYConstraint]
    }
    
}

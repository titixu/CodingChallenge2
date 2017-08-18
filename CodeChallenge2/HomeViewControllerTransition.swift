//
//  HomeViewControllerTransition.swift
//  CodeChallenge2
//
//  Created by SamXu on 18/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

import UIKit

class HomeViewControllerTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    // For custom view controller transitioning animation
    private let presentAnimationController = ModalPresentingAnimationController()
    
    private let dismissAnimationController = ModalDismissAnimationController()
    
    // change this frame to set the start location of presenting or the end location for dismissal
    var originFrame = CGRect.zero
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        presentAnimationController.originFrame = originFrame
        
        return presentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        dismissAnimationController.destinationFrame = originFrame
        
        return dismissAnimationController
    }
}

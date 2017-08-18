//
//  ModalPresentingAnimationController.swift
//  CodeChallenge2
//
//  Created by SamXu on 17/8/17.
//  Copyright © 2017 AnXu. All rights reserved.
//

/*
    Animation controllers for custom transition animation
 */

import UIKit

fileprivate let transitionAnimationDuration = 0.5

class ModalPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return transitionAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        let containerView = transitionContext.containerView
        
        let initalFrame = originFrame
        
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        guard let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true) else { return }
        
        snapshot.frame = initalFrame
        
        containerView.addSubview(toViewController.view)
        
        containerView.addSubview(snapshot)
        
        toViewController.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { 
            
            snapshot.frame = finalFrame
            
        }) { (_) in
            
            toViewController.view.isHidden = false
            
            snapshot.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

class ModalDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    //zoom (dismiss) the view into this frame
    var destinationFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return transitionAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        // fix the bug for rotation issue
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        
        let containerView = transitionContext.containerView
        
        let initalFrame = transitionContext.initialFrame(for: fromViewController)
        
        let finalFrame = destinationFrame
        
        guard let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: false) else { return }
        
        snapshot.frame = initalFrame
        
        containerView.addSubview(toViewController.view)
        
        containerView.addSubview(snapshot)
        
        fromViewController.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            
            snapshot.frame = finalFrame
            
        }) { (_) in
            
            fromViewController.view.isHidden = false
            
            snapshot.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    
}

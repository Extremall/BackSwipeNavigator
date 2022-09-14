//
//  BackSwipeAnimatedTransitioning.swift
//  AnimationCoordinators
//
//  Created by Alexander Naumenko on 11/09/2022.
//

import UIKit

class BackSwipeAnimatedTransitioning: NSObject {
    
}

extension BackSwipeAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
              let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let fromView = fromVC.view
        let toView = toVC.view
        
        let originToFrame = toView?.frame ?? CGRect.zero
        
        let width = containerView.frame.width
        
        var offsetLeft = fromView?.frame
        offsetLeft?.origin.x = width
        
        var offscreenRight = toView?.frame
        offscreenRight?.origin.x = -width / 3.33

        toView?.frame = offscreenRight!
        
        fromView?.layer.shadowRadius = 5.0
        fromView?.layer.shadowOpacity = 1.0
        toView?.layer.opacity = 0.9

        let toFrame = (fromView?.frame)!
        
        containerView.insertSubview(toView!, belowSubview: fromView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
            toView?.frame = toFrame
            fromView?.frame = offsetLeft!

            toView?.layer.opacity = 1.0
            fromView?.layer.shadowOpacity = 0.1
        }, completion: { _ in
            toView?.layer.opacity = 1.0
            toView?.layer.shadowOpacity = 0
            fromView?.layer.opacity = 1.0
            fromView?.layer.shadowOpacity = 0

            toView?.frame = originToFrame
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

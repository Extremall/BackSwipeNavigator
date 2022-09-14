//
//  BackSwipeNavManager.swift
//  AnimationCoordinators
//
//  Created by Alexander Naumenko on 11/09/2022.
//

import UIKit

class BackSwipeNavManager: NSObject, UINavigationControllerDelegate {
    var navigationData: BackSwipeNavigationData!
    var navController: BackSwipeNavigationController!
    
    init(data: BackSwipeNavigationData,
               navController: BackSwipeNavigationController) {
        navigationData = data
        self.navController = navController
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if navigationData.duringPushAnimation {
            return nil
        }

        return BackSwipeAnimatedTransitioning()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationData.duringPushAnimation = false
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        if navigationData.duringPushAnimation {
            return nil
        }

        if navController.panGestureRecognizer.state == .began {
            navigationData.percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            navigationData.percentDrivenInteractiveTransition.completionCurve = .easeOut
        } else {
            navigationData.percentDrivenInteractiveTransition = nil
        }

        return navigationData.percentDrivenInteractiveTransition
    }
    
    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        let percent = max(panGesture.translation(in: navController.view).x, 0) / navController.view.frame.width

        switch panGesture.state {

        case .began:
            guard navController.viewControllers.count > 1 else {
                return
            }

            navController.delegate = self
            navigationData.duringPopAnimation = true
            navController.popViewController(animated: true)

        case .changed:
            if let percentDrivenInteractiveTransition = navigationData.percentDrivenInteractiveTransition {
                percentDrivenInteractiveTransition.update(percent)
            }

        case .ended:

            navigationData.duringPopAnimation = false
            guard let percentDrivenInteractiveTransition = navigationData.percentDrivenInteractiveTransition else { return }

            let velocity = panGesture.velocity(in: navController.view).x

            // Continue if drag more than 50% of screen width or velocity is higher than 1000
            if percent > 0.5 || velocity > 1000 {
                percentDrivenInteractiveTransition.finish()
            } else {
                percentDrivenInteractiveTransition.cancel()
                navigationData.percentDrivenInteractiveTransition = nil
            }

        case .cancelled,
             .failed:

            navigationData.duringPopAnimation = false
            guard let percentDrivenInteractiveTransition = navigationData.percentDrivenInteractiveTransition else { return }

            percentDrivenInteractiveTransition.cancel()
            navigationData.percentDrivenInteractiveTransition = nil

        default:
            break
        }
    }
}

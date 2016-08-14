//
//  CustomTransitioning.swift
//  Dribble
//
//  Created by 王笛 on 16/8/14.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class CustomTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! WelcomeViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let container = transitionContext.containerView()
        let snapshotView = fromVC.view.snapshotViewAfterScreenUpdates(false)
        let y = toVC.view.frame.size.height
        
        snapshotView.frame = container!.convertRect(fromVC.view.frame, fromView: fromVC.view)
        container?.addSubview(toVC.view)
        container?.addSubview(snapshotView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: .CurveEaseInOut, animations: {
            fromVC.view.alpha = 0
            snapshotView.alpha = 0
            snapshotView.frame = CGRect(x: 0, y: -y, width: toVC.view.frame.size.width, height: toVC.view.frame.size.height)
            }) { (Bool) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
    
}

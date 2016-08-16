//
//  WelcomeViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/8/14.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //var swipe: UISwipeGestureRecognizer!
    let transition = BubbleTransition()
    @IBOutlet weak var transitionButton: UIButton!
    //@IBOutlet weak var onboarding: PaperOnboarding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.transitionButton.layer.cornerRadius = 23
        
        //onboarding = PaperOnboarding(itemsCount: 3)
        //onboarding.dataSource = self
        //onboarding.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(onboarding)
        /*
        for attribute: NSLayoutAttribute in [.Left, .Right, . Top, .Bottom] {
            let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute, relatedBy: .Equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
 */
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.swipe = UISwipeGestureRecognizer(target: self, action: #selector(WelcomeViewController.swiped))
        //swipe.direction = .Up
        //self.view.addGestureRecognizer(swipe)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = transitionButton.center
        transition.bubbleColor = transitionButton.backgroundColor!
        return transition
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /*
    func swiped() {
        print("Swiped")
        self.navigationController?.popViewControllerAnimated(true)
        self.performSegueWithIdentifier("Welcome", sender: nil)
    }
 */
    /*
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Push {
            print("Success")
            return CustomTransitioning()
        } else {
            print("Fail")
            return nil
        }
    }
    */
}

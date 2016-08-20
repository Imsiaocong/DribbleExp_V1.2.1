//
//  WelcomeViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/8/14.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIViewControllerTransitioningDelegate, UIScrollViewDelegate {
    
    //var swipe: UISwipeGestureRecognizer!
    let transition = BubbleTransition()
    let pageNumberCount = 3
    
    private var scrollView: UIScrollView!
    @IBOutlet weak var transitionButton: UIButton!
    //@IBOutlet weak var onboarding: PaperOnboarding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.bounds
        self.view.backgroundColor = UIColor.whiteColor()
        self.transitionButton.layer.cornerRadius = 43
        self.transitionButton.alpha = 0
        
        scrollView = UIScrollView(frame: frame)
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(pageNumberCount), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index in 0..<pageNumberCount {
            let imageView = UIImageView(image: UIImage(named: "\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, atIndex: 0)
        
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
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
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

extension WelcomeViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let currentPage = Int(offset.x / view.bounds.width)
        
        if currentPage == 2 {
            UIView.animateWithDuration(0.5, animations: { 
                self.transitionButton.alpha = 1
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.2, animations: { 
                self.transitionButton.alpha = 0
                }, completion: nil)
        }
    }
}

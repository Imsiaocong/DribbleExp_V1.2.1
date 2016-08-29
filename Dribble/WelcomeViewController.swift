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
    @IBOutlet weak var expButton: UIButton!
    
    var pageControl: GuttlerPageControl!
    private var scrollView: UIScrollView!
    var transitionButton: UIButton!
    //@IBOutlet weak var onboarding: PaperOnboarding!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .Available {
            registerForPreviewingWithDelegate(self, sourceView: view)
        }
        
        let frame = self.view.bounds
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.transitionButton = UIButton()
        self.transitionButton.frame = CGRect(x: frame.midX-42, y: self.view.frame.size.height, width: 84, height: 84)
        self.transitionButton.addTarget(self, action: #selector(WelcomeViewController.didClick), forControlEvents: .TouchUpInside)
        self.transitionButton.layer.cornerRadius = 43
        self.transitionButton.backgroundColor = UIColor.redColor()
        self.transitionButton.alpha = 0
        self.view.addSubview(transitionButton)
        
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
            let imageView = UIImageView(image: UIImage(named: "W\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, atIndex: 0)
        
        pageControl = GuttlerPageControl(center: CGPoint(x: view.center.x, y: view.center.y+300), pages:pageNumberCount)
        pageControl.bindScrollView = scrollView
        view.addSubview(pageControl)

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
    
    func didClick() {
        self.performSegueWithIdentifier("ToMain", sender: self)
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

}

extension WelcomeViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.pageControl.scrollWithScrollView(scrollView)
        
        let offset = scrollView.contentOffset
        let currentPage = Int(offset.x / view.bounds.width)
        
        if currentPage == 2 {
            UIView.animateWithDuration(0.5, animations: { 
                self.transitionButton.alpha = 1
                self.transitionButton.frame = CGRect(x: self.view.bounds.midX-42, y: self.view.frame.size.height-200, width: 84, height: 84)
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.2, animations: { 
                self.transitionButton.alpha = 0
                self.transitionButton.frame = CGRect(x: self.view.bounds.midX-42, y: self.view.frame.size.height, width: 84, height: 84)
                }, completion: nil)
        }
    }
}

extension WelcomeViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        return CGRectContainsPoint(transitionButton.frame, location) ? ViewController() : nil
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        showViewController(viewControllerToCommit, sender: self)
    }
}

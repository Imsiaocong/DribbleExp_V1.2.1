//
//  WelcomeViewController.swift
//  Dribble
//
//  Created by 王笛 on 16/8/14.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UINavigationControllerDelegate {
    
    var swipe: UISwipeGestureRecognizer!
    var intro: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        self.view.alpha = 1
        self.intro = UILabel()
        self.intro.frame = self.view.bounds
        self.intro.text = "Welcome Page"
        self.intro.adjustsFontSizeToFitWidth = true
        self.view.addSubview(intro)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
        self.swipe = UISwipeGestureRecognizer(target: self, action: #selector(WelcomeViewController.swiped))
        swipe.direction = .Up
        self.view.addGestureRecognizer(swipe)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func swiped() {
        print("Swiped")
        self.navigationController?.popViewControllerAnimated(true)
        self.performSegueWithIdentifier("Welcome", sender: nil)
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Push {
            print("Success")
            return CustomTransitioning()
        } else {
            print("Fail")
            return nil
        }
    }
    
}

//
//  ViewControllerExtension.swift
//  Dribble
//
//  Created by 王笛 on 16/8/8.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit

extension ViewController{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panned(_:)))
        //self.view.addGestureRecognizer(pan)
        
        self.path = UIBezierPath()
        
        self.shapeLayer = CAShapeLayer()
        self.shapeLayer.fillColor = UIColor.orangeColor().CGColor
        self.view.layer.insertSublayer(self.shapeLayer, atIndex: 0)
        
        //let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panned(_:)))
        
        scrollView.addGestureRecognizer(pan)
        
        if scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <= 180{
            self.backgroundPic.image = UIImage(named: "0")
        }
        if scrollView.contentOffset.x > 180 && scrollView.contentOffset.x <= 560{
            self.backgroundPic.image = UIImage(named: "1")
        }
        if scrollView.contentOffset.x > 560 && scrollView.contentOffset.x <= 935{
            self.backgroundPic.image = UIImage(named: "2")
        }
        if scrollView.contentOffset.x > 935 && scrollView.contentOffset.x <= 1310{
            self.backgroundPic.image = UIImage(named: "3")
        }
        if scrollView.contentOffset.x > 1310 && scrollView.contentOffset.x <= 2000{
            self.backgroundPic.image = UIImage(named: "4")
        }
    }
    
    func panned(pan: UIPanGestureRecognizer) {
        let h:CGFloat = CGRectGetHeight(self.view.frame)
        let innerControlPointRatio:CGFloat = 0.7
        let outerControlPointDistance:CGFloat = 75
        
        
        
        //我们希望得到触及点的Y坐标，但为了平滑的开始我们只希望得到沿着X轴的变化.
        let touchPoint:CGPoint = CGPointMake(pan.locationInView(pan.view).x, pan.locationInView(pan.view).y)
        
        if pan.state == UIGestureRecognizerState.Began || pan.state == UIGestureRecognizerState.Changed {
            self.path.removeAllPoints()
            self.path.moveToPoint(CGPointZero)
            
            //接下来的两步至关重要
            //贝希尔弧线从左上角到触点
            self.path.addCurveToPoint(CGPointMake(0, h), controlPoint1: CGPointMake(0, touchPoint.y * innerControlPointRatio), controlPoint2: CGPointMake(0, touchPoint.y-outerControlPointDistance))
            //还有从左下角到触点也做一个贝希尔弧线
            self.path.addCurveToPoint(CGPointMake(0, 0), controlPoint1: CGPointMake(touchPoint.x, touchPoint.y * innerControlPointRatio), controlPoint2: CGPointMake(0, touchPoint.y + (h - touchPoint.y) * (1.0 - innerControlPointRatio)))
            self.path.closePath()
        }else if pan.state == UIGestureRecognizerState.Ended || pan.state == UIGestureRecognizerState.Cancelled {
            // When pan is done animate the shape layer back to line.
            // However, for path morphing animation to work, it needs
            // to have same number of points as current path (3).
            // Also, this could be done with just 2 lines, but we'll
            // use curves insted for morphing to be smoother.
            // With lines there would be a pointy tip visible towards end.
            self.path.removeAllPoints()
            self.path.moveToPoint(CGPointZero)
            self.path.addCurveToPoint(CGPointMake(0, h), controlPoint1: CGPointMake(0, touchPoint.y*innerControlPointRatio), controlPoint2: CGPointMake(0, touchPoint.y-outerControlPointDistance))
            self.path.addCurveToPoint(CGPointMake(0, 0), controlPoint1: CGPointMake(0, touchPoint.y+outerControlPointDistance), controlPoint2: CGPointMake(0, touchPoint.y+(h-touchPoint.y)*(1.0-innerControlPointRatio)))
            self.path.closePath()
            let returnAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
            returnAnimation.toValue = self.path
            self.shapeLayer.addAnimation(returnAnimation, forKey: nil)
        }
        // Give the new path to shape layer to draw.
        // Disable actions to prevent implicit animation
        // since we are drawing every frame manually during
        // pan, or adding explicit animation when pan ends.
        CATransaction.begin()
        CATransaction.disableActions()
        self.shapeLayer.path = self.path.CGPath
        CATransaction.commit()
    }
    
    func addContent(state: didApear) {
        switch state {
        case .yes:
            print("Yes!")
        case .no:
            print("No!")
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        switch Device.version(){
        case .iPhone6S: return 110
        case .iPhone6SPlus: return 150
        default: return 110
        }
    }
    
}

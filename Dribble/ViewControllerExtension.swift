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
        
        let offSet_x = -scrollView.contentOffset.x
        let h = self.view.frame.size.height
        let v_rollSpeed: CGFloat = 1.5
        var v_width: CGFloat = 0
        v_width += offSet_x
        
        if v_width > 0 {
            let progress = v_width/100
            
            if progress > 0.8 {
                exp()
            }
            
            self.path.removeAllPoints()
            self.path.moveToPoint(CGPointZero)
            
            self.path.addCurveToPoint(CGPointMake(0, h), controlPoint1: CGPointMake(v_width * v_rollSpeed, h/2), controlPoint2: CGPointMake(0, h))
            self.path.addCurveToPoint(CGPointMake(0, 0), controlPoint1: CGPointMake(0, h/2), controlPoint2: CGPointMake(0, h))
            self.path.closePath()
            self.shapeLayer.path = self.path.CGPath
        }
        
        if scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <= 180{
            self.backgroundPic.image = UIImage(named: "0")
        }else if scrollView.contentOffset.x > 180 && scrollView.contentOffset.x <= 560{
            self.backgroundPic.image = UIImage(named: "1")
        }else if scrollView.contentOffset.x > 560 && scrollView.contentOffset.x <= 935{
            self.backgroundPic.image = UIImage(named: "2")
        }else if scrollView.contentOffset.x > 935 && scrollView.contentOffset.x <= 1310{
            self.backgroundPic.image = UIImage(named: "3")
        }else if scrollView.contentOffset.x > 1310 && scrollView.contentOffset.x <= 2000{
            self.backgroundPic.image = UIImage(named: "4")
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
        case .iPhone5S, .iPhone5: return 80
        case .iPhone6S, .iPhone6: return 110
        case .iPhone6SPlus, .iPhone6Plus: return 150
        default: return 110
        }
    }
    
    func exp() {
        print("function called.")
    }
    
}

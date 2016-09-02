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
        
        let offset_x = collectionView.contentSize.width / 5
        
        let row = scrollView.contentOffset.x / offset_x
        
        print(Double(row))
        
        let offSet_x = -scrollView.contentOffset.x
        let h = self.view.frame.size.height
        let v_rollSpeed: CGFloat = 1.5
        var v_width: CGFloat = 0
        v_width += offSet_x
        
        if v_width > 0 {
            let progress = v_width/100
            
            if progress > 0.8 {
                self.toNextVC = "EasternEgg"
                self.performSegueWithIdentifier("EasternEgg", sender: self)
            }
            
            self.path.removeAllPoints()
            self.path.moveToPoint(CGPointZero)
            
            self.path.addCurveToPoint(CGPointMake(0, h), controlPoint1: CGPointMake(v_width * v_rollSpeed, h/2), controlPoint2: CGPointMake(0, h))
            self.path.addCurveToPoint(CGPointMake(0, 0), controlPoint1: CGPointMake(0, h/2), controlPoint2: CGPointMake(0, h))
            self.path.closePath()
            self.shapeLayer.path = self.path.CGPath
        }
        
        if Double(row) >= 0 && Double(row) < 0.5{
            self.backgroundPic.image = UIImage(named: "0")
        }else if Double(row) >= 0.5 && Double(row) < 1.5{
            self.backgroundPic.image = UIImage(named: "1")
        }else if Double(row) >= 1.5 && Double(row) < 2.5{
            self.backgroundPic.image = UIImage(named: "2")
        }else if Double(row) >= 2.5 && Double(row) < 3.5{
            self.backgroundPic.image = UIImage(named: "3")
        }else if Double(row) >= 3.5 && Double(row) < 4.5{
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
        case .iPhone5S, .iPhone5: return 55
        case .iPhone6S, .iPhone6: return 110
        case .iPhone6SPlus, .iPhone6Plus: return 150
        default: return 55
        }
    }
    
}

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
        let shapeLayer = CAShapeLayer()
        let mainPath1 = UIBezierPath()
        let getMid = self.view.frame.size.width/2
        //print(scrollView.contentOffset.x)
        //pageControl.scrollWithScrollView(collectionView)
        if scrollView.contentOffset.x < 0 {
            shapeLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width/2, height: self.view.frame.size.height)
            shapeLayer.fillColor = UIColor.blueColor().CGColor
            mainPath1.moveToPoint(CGPoint(x: 0, y: 0))
            mainPath1.addCurveToPoint(CGPointMake(0, self.view.frame.size.height), controlPoint1: CGPointMake(getMid, 0), controlPoint2: CGPointMake(getMid*1.5, 0))
            shapeLayer.path = mainPath1.CGPath
            self.view.layer.insertSublayer(shapeLayer, atIndex: 0)
        }
        
        if scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <= 180{
            self.backgroundPic.image = UIImage(named: "0")
            mainPath1.removeAllPoints()
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

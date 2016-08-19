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
        
        //print(scrollView.contentOffset.x)
        //pageControl.scrollWithScrollView(collectionView)
        
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

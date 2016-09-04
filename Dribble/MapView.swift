//
//  ViewController.swift
//  MapKitEXP
//
//  Created by 王笛 on 16/7/12.
//  Copyright © 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var map: MKMapView!
    let annotation = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(map)
        annoted()
        map.mapType = .Hybrid
        
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.001
        let longDelta = 0.001
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //定义地图区域和中心坐标（
        //使用当前位置
        //var center:CLLocation = locationManager.location.coordinate
        //使用自定义位置
        let center:CLLocation = CLLocation(latitude: 32.029171, longitude: 118.788231)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                                  span: currentLocationSpan)
        
        //设置显示区域
        self.map.setRegion(currentRegion, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func annoted() {
        annotation.coordinate = CLLocation(latitude: 112.112443, longitude: 30.019562).coordinate
        annotation.title = "My Location"
        self.map.addAnnotation(annotation)
    }
    
    func setMapLocation(coordinate: CLLocationCoordinate2D, distance: Double, animated: Bool) {
        //[self saveLocationLatitude:coordinate.latitude Longitude:coordinate.longitude ];
        let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, distance, distance)
        let adjustedRegion: MKCoordinateRegion = self.map.regionThatFits(viewRegion)
        self.map.setRegion(adjustedRegion, animated: animated)
    }

}


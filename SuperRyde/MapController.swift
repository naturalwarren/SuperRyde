//
//  ViewController.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/27/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import UIKit

import SnapKit
import MapKit

class MapController: UIViewController {

    let uberApi = UberApi()
    let lyftApi = LyftApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uberRequest = PriceEstimateRequest(startLatitude: 37.7752315,
                                               startLongitude: -122.418075,
                                               endLatitude: 37.7752415,
                                               endLongitude: -122.518075)
        uberApi.loadPriceEstimate(request: uberRequest)
        
        let lyftRequest = CostEstimateRequest(startLatitude: 37.7752315,
                                              startLongitude: -122.418075,
                                              endLatitude: 37.7752415,
                                              endLongitude: -122.518075)
        lyftApi.loadCostEstimate(request: lyftRequest)
        
        // Create MapViewModel using CostEstimareResponse and PriceEstimateResponse
        // Subscribe to ViewModel and update the View with each item
        
        let superview = self.view
        
        let mapKitView = MKMapView()
        superview?.addSubview(mapKitView)
        
        mapKitView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.center.equalTo(self.view)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


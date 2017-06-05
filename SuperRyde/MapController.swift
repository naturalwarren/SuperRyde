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
import RxSwift

class MapController: UIViewController {
    
    var lyftAuthToken = String()
    let uberApi = UberApi()
    let lyftApi = LyftApi()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uberRequest = PriceEstimateRequest(startLatitude: 37.7752315,
                                               startLongitude: -122.418075,
                                               endLatitude: 37.7752415,
                                               endLongitude: -122.518075)
        uberApi.loadPriceEstimate(request: uberRequest)
            .subscribeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let priceEstimateResponse):
                    if let prices = priceEstimateResponse.prices {
                        for price in prices {
                            print("\(price.displayName) \(price.estimate)")
                        }
                    }
                case .error(let error):
                    print("Error: ", error)
                }
        }.addDisposableTo(disposeBag)
        
        let lyftRequest = CostEstimateRequest(startLatitude: 37.7752315,
                                              startLongitude: -122.418075,
                                              endLatitude: 37.7752415,
                                              endLongitude: -122.518075)
        lyftApi.authenticate()
            .subscribeOn(MainScheduler.instance)
            .flatMap({ (token) -> Single<CostEstimateResponse> in
                self.lyftAuthToken = token
                return self.lyftApi.loadCostEstimate(token: token, request: lyftRequest)
            })
            .subscribeOn(MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .success(let costEstimateResponse):
                    if let estimates = costEstimateResponse.estimates {
                        for estimate in estimates {
                            print("\(estimate.displayName) $\(estimate.estimatedMinCost/100)-\(estimate.estimatedMaxCost/100)")
                        }
                    }
                case .error(let error):
                    print("Error: ", error)
                }
            }.addDisposableTo(disposeBag)
        
        // Create MapViewModel using CostEstimateResponse and PriceEstimateResponse
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


//
//  ViewController.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/27/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SnapKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uberRequest = PriceEstimateRequest(startLatitude: 37.7752315,
                                               startLongitude: -122.418075,
                                               endLatitude: 37.7752415,
                                               endLongitude: -122.518075)
//        Alamofire.request(uberRequest.url(), headers: UberApi.HEADERS).responseObject { (response: DataResponse<PriceEstimateResponse>) in
//            let priceEstimate = response.result.value
//            if let prices = priceEstimate?.prices {
//                for price in prices {
//                    print("Name: " + price.displayName + " Estimate: " + price.estimate)
//                }
//            }
//        }

        let lyftRequest = CostEstimateRequest(startLatitude: 37.7752315,
                                              startLongitude: -122.418075,
                                              endLatitude: 37.7752415,
                                              endLongitude: -122.518075)
//        Alamofire.request(AuthenticationRequest.url,
//                          method:.post,
//                          parameters: AuthenticationRequest().toJSON(),
//                          encoding:JSONEncoding.default,
//                          headers: LyftApi.PRE_AUTH_HEADERS)
//            .authenticate(user: AuthenticationRequest.user, password: AuthenticationRequest.password)
//            .responseObject {(response: DataResponse<AuthenticationResponse>) in
//                let token = response.result.value!.accessToken
//                Alamofire.request(lyftRequest.url(), method:.get, parameters: nil, encoding:JSONEncoding.default, headers: ["Authorization" : "bearer \(token)"])
//                    .responseObject { (response: DataResponse<CostEstimateResponse>) in
//                        let costEstimateResponse = response.result.value
//                        if let prices = costEstimateResponse?.estimates {
//                            for estimate in prices {
//                                print("Name: \(estimate.displayName) Estimate: \(estimate.estimatedMinCost)-\(estimate.estimatedMaxCost)")
//                            }
//                        }
//                    }
//            }
        
        
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


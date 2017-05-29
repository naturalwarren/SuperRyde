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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uberRequest = PriceEstimateRequest(startLatitude: 37.7752315,
                                               startLongitude: -122.418075,
                                               endLatitude: 37.7752415,
                                               endLongitude: -122.518075)
        Alamofire.request(uberRequest.url(), headers: UberApi.HEADERS).responseObject { (response: DataResponse<PriceEstimateResponse>) in
            let priceEstimate = response.result.value
            if let prices = priceEstimate?.prices {
                for price in prices {
                    print("Name: " + price.displayName + " Estimate: " + price.estimate)
                }
            }
        }

        var accessToken: String = ""
        Alamofire.request(AuthenticationRequest.url,
                          method:.post,
                          parameters: AuthenticationRequest().toJSON(),
                          encoding:JSONEncoding.default,
                          headers: LyftApi.PRE_AUTH_HEADERS)
            .authenticate(user: AuthenticationRequest.user, password: AuthenticationRequest.password).responseObject { (response: DataResponse<AuthenticationResponse>) in
                let authenticationResponse = response.result.value!
                accessToken = authenticationResponse.accessToken
        }
        
        let lyftRequest = CostEstimateRequest(startLatitude: 37.7752315,
                                              startLongitude: -122.418075,
                                              endLatitude: 37.7752415,
                                              endLongitude: -122.518075)
    
        Alamofire.request(lyftRequest.url(),
                          method:.get,
                          parameters: nil,
                          encoding:JSONEncoding.default,
                          headers: ["Authorization" : "bearer gAAAAABZK2byB4Aqh9hcND4dIsfycZrA40Bmc9p5luXtxSuBTrCN6Y0SzrtxBu_ZMbdFJ-K4K6xuu_lWs4wsxUlXYyqvd0E0JwKOYJOAzJoghx0iJEqumUCk-5oEKxOR-tCOt0WraxLs7xT4ov_RHuA0q7VxFwKwGEKYEyT4E9Q7XfeM6vP86GHFVG6c0Mcnod0cGyL9TNag-C7QAxTMhQ0lE7b2x0xozw=="])
            .responseObject { (response: DataResponse<CostEstimateResponse>) in
            let costEstimateResponse = response.result.value
            if let prices = costEstimateResponse?.estimates {
                for estimate in prices {
                    print("Name: \(estimate.displayName) Estimate: \(estimate.estimatedCostMinCents) - \(estimate.estimatedCostMaxCents)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


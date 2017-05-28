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
        
        let request = PriceEstimateRequest(startLatitude: "37.7752315",
                                           startLongitude: "-122.418075",
                                           endLatitude: "37.7752415",
                                           endLongitude: "-122.518075")
        
        Alamofire.request(request.url(), headers: UberApi.HEADERS).responseObject { (response: DataResponse<PriceEstimateResponse>) in
            let priceEstimate = response.result.value

            if let prices = priceEstimate?.prices {
                for price in prices {
                    print("Name: " + price.displayName + " Estimate: " + price.estimate)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  UberAPI.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation

class UberApi {
    static let BASE_URL = "https://api.uber.com/v1.2/"
    
    static let HEADERS = [
        "Authorization": "Token jgLiCncpw6g1bopAahrf3R9LaN2MBIh124Tg6XdG",
        "Accept-Language": "en_US",
        "Content-Type": "application/json"
    ]
    
    func loadPriceEstimate(request: PriceEstimateRequest) {
        Alamofire.request(request.url(), headers: UberApi.HEADERS).responseObject { (response: DataResponse<PriceEstimateResponse>) in
            let priceEstimate = response.result.value
            if let prices = priceEstimate?.prices {
                for price in prices {
                    print("Name: " + price.displayName + " Estimate: " + price.estimate)
                }
            }
        }
    }
}

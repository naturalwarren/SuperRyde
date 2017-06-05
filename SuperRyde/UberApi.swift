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
import RxSwift

/* Reactive wrapper around Alamofire configured to make Uber API calls. */
class UberApi {
    
    static let BASE_URL = "https://api.uber.com/v1.2/"
    static let HEADERS = [
        "Authorization": "Token jgLiCncpw6g1bopAahrf3R9LaN2MBIh124Tg6XdG",
        "Accept-Language": "en_US",
        "Content-Type": "application/json"
    ]
    
    func loadPriceEstimate(request: PriceEstimateRequest) -> Single<PriceEstimateResponse> {
        return Single<PriceEstimateResponse>.create{ single in
            let request = Alamofire.request(request.url(), headers: UberApi.HEADERS).responseObject { (response: DataResponse<PriceEstimateResponse>) in
                if let priceEstimate = response.result.value {
                    single(.success(priceEstimate))
                }
                // What to do for failure cases?
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

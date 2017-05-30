//
//  LyftApi.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Alamofire
import ObjectMapper
import Foundation
import RxSwift

class LyftApi {
    
    static let BASE_URL = "https://api.lyft.com/v1/"
    
    static let PRE_AUTH_HEADERS = [
        "Content-Type": "application/json"
    ]
    
    func loadCostEstimate(request: CostEstimateRequest) {
        Alamofire.request(AuthenticationRequest.url,
                          method:.post,
                          parameters: AuthenticationRequest().toJSON(),
                          encoding:JSONEncoding.default,
                          headers: LyftApi.PRE_AUTH_HEADERS)
            .authenticate(user: AuthenticationRequest.user, password: AuthenticationRequest.password)
            .responseObject {(response: DataResponse<AuthenticationResponse>) in
                let token = response.result.value!.accessToken
                Alamofire.request(request.url(), method:.get, parameters: nil, encoding:JSONEncoding.default, headers: ["Authorization" : "bearer \(token)"])
                    .responseObject { (response: DataResponse<CostEstimateResponse>) in
                        let costEstimateResponse = response.result.value
                        if let prices = costEstimateResponse?.estimates {
                            for estimate in prices {
                                print("Name: \(estimate.displayName) Estimate: \(estimate.estimatedMinCost)-\(estimate.estimatedMaxCost)")
                            }
                        }
                }
        }
        
        // We need to be able to return Single<CostEstimateResponse>
    }
}

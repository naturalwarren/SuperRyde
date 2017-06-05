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

/* Reactive wrapper around Alamofire configured to make Lyft API calls. */
class LyftApi {
    
    static let BASE_URL = "https://api.lyft.com/v1/"
    
    func authenticate() -> Single<String> {
        return Single<String>.create { single in
            let request = Alamofire.request(AuthenticationRequest.url,
                                            method:.post,
                                            parameters: AuthenticationRequest().toJSON(),
                                            encoding:JSONEncoding.default,
                                            headers: ["Content-Type": "application/json"])
                .authenticate(user: AuthenticationRequest.user, password: AuthenticationRequest.password)
                .responseObject {(response: DataResponse<AuthenticationResponse>) in
                    if let value = response.result.value {
                        single(.success(value.accessToken))
                    }
                    // What to do for failure cases?
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func loadCostEstimate(token: String, request: CostEstimateRequest) -> Single<CostEstimateResponse> {
        return Single<CostEstimateResponse>.create { single in
            let request = Alamofire.request(request.url(),
                                            method:.get,
                                            parameters: nil,
                                            encoding:JSONEncoding.default,
                                            headers: ["Authorization" : "bearer \(token)"])
                .responseObject {(response: DataResponse<CostEstimateResponse>) in
                    if let value = response.result.value {
                        single(.success(value))
                    }
                    // What to do for failure cases?
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

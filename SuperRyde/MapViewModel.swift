//
//  MapViewModel.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/29/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation

class MapViewModel {
    var lyftEstimate: CostEstimateResponse
    var uberEstimate: PriceEstimateResponse
    
    init(lyftEstimate: CostEstimateResponse, uberEstimate: PriceEstimateResponse) {
        self.lyftEstimate = lyftEstimate
        self.uberEstimate = uberEstimate
    }
    
    var lyftPrices: CostEstimateResponse {
        return lyftEstimate
    }
    
    var uberPrices: PriceEstimateResponse {
        return uberEstimate
    }
    
    // We have arrays coming back, how should the ViewModel handle this?
    // Also, should there be one ViewModel per Response?
}

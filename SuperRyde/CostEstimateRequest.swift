//
//  CostEstimateRequest.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation

class CostEstimateRequest {
    
    var startLatitude: Double
    var startLongitude: Double
    var endLatitude: Double
    var endLongitude: Double
    
    init(startLatitude: Double, startLongitude: Double, endLatitude: Double, endLongitude: Double) {
        self.startLatitude = startLatitude
        self.startLongitude = startLongitude
        self.endLatitude = endLatitude
        self.endLongitude = endLongitude
    }
    
    func url() -> String {
        return LyftApi.BASE_URL + "cost?start_lat=\(startLatitude)"
            + "&start_lng=\(startLongitude)"
            + "&end_lat=\(endLatitude)"
            + "&end_lng=\(endLongitude)"
    }
}

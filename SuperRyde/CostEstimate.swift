//
//  CostEstimateRequest.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation
import ObjectMapper

class CostEstimateRequest {
    
    var startLatitude: Double
    var startLongitude: Double
    var endLatitude: Double
    var endLongitude: Double
    
    init(startLat: Double, startLong: Double, endLat: Double, endLong: Double) {
        self.startLatitude = startLat
        self.startLongitude = startLong
        self.endLatitude = endLat
        self.endLongitude = endLong
    }
    
    func url() -> String {
        return LyftApi.BASE_URL + "cost?start_lat=\(startLatitude)"
            + "&start_lng=\(startLongitude)"
            + "&end_lat=\(endLatitude)"
            + "&end_lng=\(endLongitude)"
    }
}

class CostEstimateResponse: Mappable {
    
    var estimates: [Estimate]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        estimates <- map["cost_estimates"]
    }
}

class Estimate: Mappable {
    
    var displayName: String
    var estimatedMaxCost: Double
    var estimatedMinCost: Double
    var currency: String
    
    /* We actualy don't want to set properties here, it results in them being set twice. How do we get around this
       without making everything optional? */
    required init?(map: Map) {
        do {
            try displayName = map.value("display_name")
            try estimatedMaxCost = map.value("estimated_cost_cents_max")
            try estimatedMinCost = map.value("estimated_cost_cents_min")
            try currency = map.value("currency")
        } catch {
            return nil
        }
    }
    
    func mapping(map: Map) {
        displayName <- map["display_name"]
        estimatedMaxCost <- map["estimated_cost_cents_max"]
        estimatedMinCost <- map["estimated_cost_cents_min"]
        currency <- map["currency"]
    }
}

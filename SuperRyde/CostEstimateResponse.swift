//
//  CostEstimateResponse.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import ObjectMapper
import Foundation

class CostEstimateResponse: Mappable {
    var estimates: [Estimate]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        estimates <- map["cost_estimates"]
    }
}

class Estimate: Mappable {
    
    var displayName: String
    var estimatedCostMaxCents: Double
    var estimatedCostMinCents: Double
    var currency: String
    
    required init?(map: Map) {
        do {
            try displayName = map.value("display_name")
            try estimatedCostMaxCents = map.value("estimated_cost_cents_max")
            try estimatedCostMinCents = map.value("estimated_cost_cents_min")
            try currency = map.value("currency")
        } catch {
            return nil
        }
    }
    
    func mapping(map: Map) {
        displayName <- map["display_name"]
        estimatedCostMaxCents <- map["estimated_cost_cents_max"]
        estimatedCostMinCents <- map["estimated_cost_cents_min"]
        currency <- map["currency"]
    }
}

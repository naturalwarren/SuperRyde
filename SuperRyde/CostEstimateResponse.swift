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
    var estimatedMaxCost: Double
    var estimatedMinCost: Double
    var currency: String
    
    required init?(map: Map) {
        do {
            try displayName = map.value("display_name")
            try estimatedMaxCost = map.value("estimated_cost_cents_max") / 100
            try estimatedMinCost = map.value("estimated_cost_cents_min") / 100
            try currency = map.value("currency")
        } catch {
            return nil
        }
    }
    
    func mapping(map: Map) {
        let transform = TransformOf<Double, Double>(fromJSON: { (value: Double?) -> Double in
            return value!/100
        }, toJSON: { (value:Double?) -> Double in
            return value! * 100
        })
        
        displayName <- map["display_name"]
        estimatedMaxCost <- (map["estimated_cost_cents_max"], transform)
        estimatedMinCost <- (map["estimated_cost_cents_min"], transform)
        currency <- map["currency"]
    }
}

//
//  PriceEstimateRequest.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/27/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation
import ObjectMapper

class PriceEstimateRequest {

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
        return UberApi.BASE_URL + "estimates/price?start_latitude=\(startLatitude)"
            + "&start_longitude=\(startLongitude)"
            + "&end_latitude=\(endLatitude)"
            + "&end_longitude=\(endLongitude)"
    }
}

class PriceEstimateResponse : Mappable {
    
    var prices: [Price]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        prices <- map["prices"]
    }
}

class Price: Mappable {
    
    var displayName: String
    var distance: Double
    var highEstimate: Double
    var lowEstimate: Double
    var estimate: String
    var currencyCode: String
    
    required init?(map: Map) {
        do {
            try displayName = map.value("display_name")
            try distance = map.value("distance")
            try highEstimate = map.value("high_estimate")
            try lowEstimate = map.value("low_estimate")
            try estimate = map.value("estimate")
            try currencyCode = map.value("currency_code")
        } catch {
            return nil
        }
    }
    
    func mapping(map: Map) {
        displayName <- map["display_name"]
        distance <- map["distance"]
        highEstimate <- map["high_estimate"]
        lowEstimate <- map["low_estimate"]
        estimate <- map["estimate"]
        currencyCode <- map["currency_code"]
    }
}

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

    var startLatitude: String
    var startLongitude: String
    var endLatitude: String
    var endLongitude: String

    init(startLatitude: String, startLongitude: String, endLatitude: String, endLongitude: String) {
        self.startLatitude = startLatitude
        self.startLongitude = startLongitude
        self.endLatitude = endLatitude
        self.endLongitude = endLongitude
    }

    func url() -> String {
        return UberApi.BASE_URL + "estimates/price?start_latitude=\(startLatitude)"
            + "&start_longitude=\(startLongitude)"
            + "&end_latitude=\(endLatitude)"
            + "&end_longitude=\(endLongitude)"
    }
}

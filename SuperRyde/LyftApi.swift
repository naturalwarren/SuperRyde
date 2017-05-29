//
//  LyftApi.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation

class LyftApi {
    
    static let BASE_URL = "https://api.lyft.com/v1/"
    
    static let PRE_AUTH_HEADERS = [
        "Content-Type": "application/json"
    ]
    
    func postAuthHeaders(accessToken: String) -> Dictionary<String, String> {
        return ["Authorization" : "bearer " + accessToken]
    }
    
}

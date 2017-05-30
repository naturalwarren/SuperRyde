//
//  AuthenticationRequest.swift
//  SuperRyde
//
//  Created by Warren Smith on 5/28/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import Foundation
import ObjectMapper

class AuthenticationRequest: Mappable {

    var grantType: String
    var scope:String
    
    static let url = "https://api.lyft.com/oauth/token"
    static let user = "nW7JvtEUlIgw"
    static let password = "d425uRD9hRUTd98cccWHhmczyX9zIQ6c"
    
    init() {
        self.grantType = "client_credentials"
        self.scope = "public"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        grantType <- map["grant_type"]
        scope <- map["scope"]
    }
}

class AuthenticationResponse: Mappable {
    
    var accessToken: String
    var expiry: NSInteger
    var tokenType: String
    var scope: String
    
    required init?(map: Map) {
        do {
            try accessToken = map.value("access_token")
            try expiry = map.value("expires_in")
            try scope = map.value("scope")
            try tokenType = map.value("token_type")
        } catch {
            return nil
        }
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        expiry <- map["expires_in"]
        scope <- map["scope"]
        tokenType <- map["token_type"]
    }
}

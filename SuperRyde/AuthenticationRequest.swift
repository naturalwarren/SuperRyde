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

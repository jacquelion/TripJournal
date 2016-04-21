//
//  Constants.swift
//  TripJournal
//
//  Created by Jacqueline Sloves on 4/19/16.
//  Copyright © 2016 Jacqueline Sloves. All rights reserved.
//

import Foundation

extension InstagramClient {
    struct Constants {
        
        static let ApiScheme = "https"
        static let ApiHost = "api.instagram.com"
        static let ApiPath = "/oauth"
        
        static let AuthorizationURL : String = "https://api.instagram.com/oauth/authorize/"
        
        static let ClientId = "60e0fe0b74e849ec83f81f18b781b88f"
        static let ClientSecret = "409f6f46839b4f8a8da12c7ca46dc8bf"
        static let WebsiteURL = "http://www.jacquelinesloves.com"
        static let RedirectURI = "https://www.instagram.com/"
        static let SupportEmail = "coderjac@gmail.com"
    }
    
    struct Methods {
        static let Authorize = "/authorize/"
    }
    
    struct ParameterKeys {
        static let clientId = "client_id"
        static let redirectURI = "redirect_uri"
        static let responseType = "response_type"
    }
    
    struct ParameterValues {
        static let code = "code"
        static let token = "token"
    }
    
    struct JSONResponseKeys {
        static let accessToken = "access_token"
    }

}



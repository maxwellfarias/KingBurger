//
//  SpashRequest.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation

struct SplashRequest: Encodable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

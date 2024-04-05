//
//  UserAuth.swift
//  KingBurger
//
//  Created by Maxwell Farias on 04/09/23.
//

import Foundation

import Foundation

struct UserAuth: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String

}

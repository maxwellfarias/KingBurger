//
//  SignInRequesy.swift
//  KingBurger
//
//  Created by Maxwell Farias on 01/09/23.
//

import Foundation

struct SignInRequest: Encodable {
    let username: String
    let password: String
}

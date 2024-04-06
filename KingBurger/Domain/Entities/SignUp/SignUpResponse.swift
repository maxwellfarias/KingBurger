//
//  SignUpResponse.swift
//  KingBurger
//
//  Created by Maxwell Farias on 01/09/23.
//

import Foundation

struct SignUpResponse: Decodable {
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
}

//
//  SignUpRequest.swift
//  KingBurguer
//
//  Created by Maxwell Farias on 06/09/23.
//

import Foundation


struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let document: String
    let birthday: String
}

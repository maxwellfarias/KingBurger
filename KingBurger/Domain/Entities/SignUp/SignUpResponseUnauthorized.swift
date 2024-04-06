//
//  SignUpResponseUnauthorized.swift
//  KingBurger
//
//  Created by Maxwell Farias on 01/09/23.
//

import Foundation
//Error: 401    
struct SignUpResponseUnauthorized: Decodable {
    
    let detail: SignUpResponseDetail
   
    enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct SignUpResponseDetail: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

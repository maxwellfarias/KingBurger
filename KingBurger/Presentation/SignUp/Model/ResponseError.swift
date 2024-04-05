//
//  SignUpResponseError.swift
//  KingBurger
//
//  Created by Maxwell Farias on 01/09/23.
//

import Foundation

struct ResponseError: Decodable {
    
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

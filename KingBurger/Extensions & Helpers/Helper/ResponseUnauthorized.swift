//
//  e.swift
//  KingBurger
//
//  Created by Maxwell Farias on 02/09/23.
//

import Foundation

struct ResponseUnauthorized: Decodable {
    
    let detail: ResponseDetail
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct ResponseDetail: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

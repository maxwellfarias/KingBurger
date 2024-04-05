//
//  HighlightResponse.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation

import Foundation

struct HighlightResponse: Decodable {
    
    let id: Int
    let productId: Int
    let pictureUrl: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case pictureUrl = "picture_url"
        case createdDate = "created_date"
    }
    
}

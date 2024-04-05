//
//  FeedResponse.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation

struct FeedResponse: Decodable {
    let categories: [CategoryResponse]
}

struct CategoryResponse: Decodable {
    let id: Int
    let name: String
    let products: [ProductResponse]
}

struct ProductResponse: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let pictureUrl: String
    let price: Double
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case pictureUrl = "picture_url"
        case price
        case createdDate = "created_date"
    }
    
}

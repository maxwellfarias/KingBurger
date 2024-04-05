//
//  CouponResponseList.swift
//  KingBurger
//
//  Created by Maxwell Farias on 12/09/23.
//

import Foundation


struct CouponResponseList: Decodable {
    let total: Int
    let limit: Int
    let data: [Coupon]  
}
      
struct Coupon: Decodable {
    let id: Int
    let productId: Int
    let coupon: String
    var expiresDate: String
    var createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case coupon
        case createdDate = "created_at"
        case expiresDate = "expiration_at"
    }
}

//
//  CouponResponse.swift
//  KingBurger
//
//  Created by Maxwell Farias on 06/09/23.
//

import Foundation

//struct CouponResponse: Decodable {
//
////    let id: Int
////    let productId: Int
////    let userId: Int
////    let coupon: String
////    let expiresDate: String
////    let createdDate: String
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case productId = "product_id"
////        case userId = "user_id"
////        case coupon
////        case createdDate = "created_date"
////        case expiresDate = "expires_date"
////    }
//
//}

struct CouponResponse: Decodable {
    let id: Int
    let productId: Int
    let userId: Int
    let coupon: String
    var expiresDate: String
    var createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case productId = "product_id"
        case userId = "user_id"
        case coupon
        case createdDate = "created_date"
        case expiresDate = "expires_date"
    }
    
    
}

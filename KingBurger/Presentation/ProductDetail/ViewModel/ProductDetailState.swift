//
//  ProductDetailState.swift
//  KingBurger
//
//  Created by Maxwell Farias on 06/09/23.
//

import Foundation

enum ProductDetailState {
    case loading
    case loadindCoupon
    case success(ProductResponse)
    case successCoupon(CouponResponse)
    case error(String)
}

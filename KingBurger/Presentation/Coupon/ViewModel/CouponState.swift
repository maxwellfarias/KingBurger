//
//  CouponState.swift
//  KingBurger
//
//  Created by Maxwell Farias on 12/09/23.
//

import Foundation

enum CouponState: Equatable {
    static func == (lhs: CouponState, rhs: CouponState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    
    case loading
    case success (CouponResponseList)
    case error(String)
    case successProductDetail(ProductResponse, Int)
}

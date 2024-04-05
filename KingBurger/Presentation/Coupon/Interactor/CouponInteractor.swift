//
//  CouponInteractor.swift
//  KingBurger
//
//  Created by Maxwell Farias on 12/09/23.
//

import Foundation

class CouponInteractor {
    
    private let remote: CouponRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(currentPage: Int, listType: CouponTypeListForUrl, completion: @escaping (CouponResponseList?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access token not found!")
            return
        }
        
         remote.fetch(currentPage: currentPage, listType: listType, accessToken: accessToken, completion: completion)
    }
    
    func fetchProductDetail(id: Int, completion: @escaping (ProductResponse?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access token not found!")
            return
        }
        
        return remote.fetchProductDetail(id: id, accessToken: accessToken, completion: completion)
    }
    
}

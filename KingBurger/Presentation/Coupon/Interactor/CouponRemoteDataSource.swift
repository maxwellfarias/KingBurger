//
//  CouponRemoteDataSource.swift
//  KingBurger
//
//  Created by Maxwell Farias on 12/09/23.
//

import Foundation

class CouponRemoteDataSource {
    
    static let shared = CouponRemoteDataSource()
    
    func fetch(currentPage: Int, listType: CouponTypeListForUrl, accessToken: String, completion: @escaping (CouponResponseList?, String?) -> Void) {
        
        let path = String(format: WebServiceAPI.Endpoint.couponList.rawValue, currentPage) + listType.rawValue
        
        WebServiceAPI.shared.call(path: path, method: .get, accessToken: accessToken) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(CouponResponseList.self, from: data)
                    completion(response, nil)
                    break
                    
                case .failure(let error, let data):
                 
                    guard let data = data else { return }
                    
                    switch error {
                        case .unauthorized:
                            let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                            completion(nil, response?.detail.message)
                            break
                            
                        default:
                            let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                            completion(nil, response?.detail)
                            break
                    }
                    
                    break
            }
        }
    }
    
    func fetchProductDetail(id: Int, accessToken: String, completion: @escaping (ProductResponse?, String?) -> Void) {
        let path = String(format: WebServiceAPI.Endpoint.productDetail.rawValue, id)
        
        WebServiceAPI.shared.call(path: path, method: .get, accessToken: accessToken) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(ProductResponse.self, from: data)
                    completion(response, nil)
                    break
                    
                case .failure(let error, let data):
                    
                    guard let data = data else { return }
                    
                    switch error {
                        case .unauthorized:
                            let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                            completion(nil, response?.detail.message)
                            break
                            
                        default:
                            let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                            completion(nil, response?.detail)
                            break
                    }
                    
                    break
            }
        }
    }
}

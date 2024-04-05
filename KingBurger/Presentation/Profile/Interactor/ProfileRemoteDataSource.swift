//
//  ProfileRemoteDataSource.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import Foundation


class ProfileRemoteDataSource {
    
    static let shared = ProfileRemoteDataSource()
    
    func fetch(accessToken: String, completion: @escaping (UserResponse?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .me, body: Optional<FeedRequest>.none, method: .get, accessToken: accessToken) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(UserResponse.self, from: data)
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

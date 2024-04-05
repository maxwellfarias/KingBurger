//
//  FeedRemoteDataSource.swift
//  KingBurger
//
//  Created by Maxwell Farias on 05/09/23.
//

import Foundation

class FeedRemoteDataSource {
    
    static let shared = FeedRemoteDataSource()
    
    func fetch(accessToken: String, completion: @escaping (FeedResponse?, String?) -> Void) {
// Optional<FeedRequest>.none is the structure used to say that a generic type is null. The FeedRequest was created as an empty encodable structure for just this purpose. All this was necessary because the get method does not have body as a parameter.
        WebServiceAPI.shared.call(path: .feed, body: Optional<FeedRequest>.none, method: .get, accessToken: accessToken) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(FeedResponse.self, from: data)
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
    
    func fetchHighlight(accessToken: String, completion: @escaping (HighlightResponse?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .highlight, body: Optional<FeedRequest>.none, method: .get, accessToken: accessToken) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { return }
                    let response = try? JSONDecoder().decode(HighlightResponse.self, from: data)
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

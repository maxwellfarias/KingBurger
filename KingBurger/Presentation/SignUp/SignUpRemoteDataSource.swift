//
//  SignUpRemoteDataSource.swift
//  KingBurger
//
//  Created by Maxwell Farias on 02/09/23.
//

import Foundation

class SignUpRemoteDataSource {
    
    static let shared = SignUpRemoteDataSource()
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .createUser, body: request, method: .post) { result in
            switch result {
            case .success( _):
                completion(true, nil)
                break
                
            case .failure(let error, let data):
                guard let data = data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                case .internalError:
                    completion(nil, String(data: data, encoding: .utf8))
                    
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

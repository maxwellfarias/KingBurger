//
//  SignInResourceDataSource.swift
//  KingBurger
//
//  Created by Maxwell Farias on 04/09/23.
//

import Foundation
//this class has the function of making calls to the remote server
class SignInRemoteDataSource {
    static let shared = SignInRemoteDataSource()
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .login, body: request, method: .post) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
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
                    break
                    
                default:
                    let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
            }
        }
    }
    
    private init (){}
    
}

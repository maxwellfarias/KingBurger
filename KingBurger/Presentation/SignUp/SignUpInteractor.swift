//
//  SignUpInteractor.swift
//  KingBurger
//
//  Created by Maxwell Farias on 02/09/23.
//

import Foundation

class SignUpInteractor {
//    Singleton that make the request to the server
    private let remote: SignUpRemoteDataSource = .shared
    
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void) {
        return remote.createUser(request: request, completion: completion)
    }
    
}

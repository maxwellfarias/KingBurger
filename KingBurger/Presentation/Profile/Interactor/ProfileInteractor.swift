//
//  ProfileInteractor.swift
//  KingBurger
//
//  Created by Maxwell Farias on 07/09/23.
//

import Foundation

class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(completion: @escaping (UserResponse?, String?) -> Void) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access token not found!")
            return
        }
        
        return remote.fetch(accessToken: accessToken, completion: completion)
    }
    
}
